require "rspec"
require "vagrant"

class ZfsFixture
  def create_drive(name)
    Vagrant.new.exec "truncate -s 1TB #{name}"
    Vagrant.new.exec "sudo mdconfig -u #{name} -f #{name}"
  end

  def damage_drive(name)
    Vagrant.new.exec "dd if=/dev/zero of=#{name} bs=4M count=1"
  end

  def delete_drive(name)
    Vagrant.new.exec "sudo mdconfig -du #{name}"
    Vagrant.new.exec "rm #{name}"
  end

  def create_zpool(name, drives)
    Vagrant.new.exec "sudo zpool create #{name} raidz1 #{drives}"
  end

  def delete_zpool(name)
    Vagrant.new.exec "sudo zpool destroy #{name}"
  end
end

Given('a 3 disk raidz1 pool') do
  ZfsFixture.new.create_drive "md0"
  ZfsFixture.new.create_drive "md1"
  ZfsFixture.new.create_drive "md2"
  ZfsFixture.new.create_zpool("testpool", "/dev/md0 /dev/md1 /dev/md2")

  output = Vagrant.new.exec "zpool status testpool"
  # pool: testpool
  #  state: ONLINE
  # config:
  #
  #  NAME        STATE     READ WRITE CKSUM
  #  testpool    ONLINE       0     0     0
  #    raidz1-0  ONLINE       0     0     0
  #      md0     ONLINE       0     0     0
  #      md1     ONLINE       0     0     0
  #      md2     ONLINE       0     0     0
  #
  # errors: No known data errors
  expect(output).to match(/pool: testpool/)
end

# Thanks to this post as a great reference:
# https://wiki.archlinux.org/title/ZFS/Virtual_disks
And('it contains some data') do
  Vagrant.new.exec "sudo mkdir -m 777 /testpool/data"
  Vagrant.new.scp("features/data/*.txt", "/testpool/data/")
  output = Vagrant.new.exec "cat /testpool/data/Moby_Dick.txt | grep Melville"
  expect(output).to match(/Melville/)
end

Given('that one of the disks has failed') do
  ZfsFixture.new.damage_drive "md0"
  Vagrant.new.exec "sudo zpool scrub testpool"
  output = Vagrant.new.exec "zpool status testpool"
  # pool: testpool
  #  state: DEGRADED
  # status: One or more devices could not be used because the label is missing or
  #  invalid.  Sufficient replicas exist for the pool to continue
  #  functioning in a degraded state.
  # action: Replace the device using 'zpool replace'.
  #    see: https://openzfs.github.io/openzfs-docs/msg/ZFS-8000-4J
  #   scan: scrub repaired 0B in 00:00:00 with 0 errors on Sat Jul 27 09:49:17 2024
  # config:
  #
  #  NAME        STATE     READ WRITE CKSUM
  #  testpool    DEGRADED     0     0     0
  #    raidz1-0  DEGRADED     0     0     0
  #      md0     UNAVAIL      4     0     0  invalid label
  #      md1     ONLINE       0     0     0
  #      md2     ONLINE       0     0     0
  expect(output).to match(/state: DEGRADED/)
end

When('the failed disk is replaced') do
  ZfsFixture.new.create_drive "md3"
  Vagrant.new.exec "sudo zpool replace testpool /dev/md0 /dev/md3"
end

Then('my files are all still available') do
  output = Vagrant.new.exec "zpool status testpool"
  expect(output).to match(/state: ONLINE/)
  output = Vagrant.new.exec "cat /testpool/data/Moby_Dick.txt | grep Melville"
  expect(output).to match(/Melville/)
end
