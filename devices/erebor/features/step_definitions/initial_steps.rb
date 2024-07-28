require "rspec"
require "vagrant"

class ZfsFixture
  def initialize
    @vagrant = Vagrant.new
  end

  def create_drive(name, size)
    @vagrant.exec "truncate -s #{size} #{name}"
    @vagrant.exec "sudo mdconfig -u #{name} -f #{name} || true"
  end

  def damage_drive(name)
    @vagrant.exec "dd if=/dev/zero of=#{name} bs=4M count=1"
  end

  def delete_drive(name)
    @vagrant.exec "sudo mdconfig -du #{name} || true"
    @vagrant.exec "rm -f #{name}"
  end

  def create_zpool(name, drives)
    @vagrant.exec "sudo zpool create #{name} raidz1 #{drives}"
  end

  def delete_zpool(name)
    @vagrant.exec "sudo zpool destroy #{name}"
  end
end

Given('a 3 disk raidz1 pool') do
  @vagrant = Vagrant.new
  @zfs = ZfsFixture.new
  @zfs.create_drive("md0", "1TB")
  @zfs.create_drive("md1", "1TB")
  @zfs.create_drive("md2", "1TB")
  @zfs.create_zpool("testpool", "/dev/md0 /dev/md1 /dev/md2")

  output = @vagrant.exec "zpool status testpool"
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
  @vagrant.exec "sudo mkdir -m 777 /testpool/data"
  @vagrant.scp("features/data/*.txt", "/testpool/data/")
  output = @vagrant.exec "cat /testpool/data/Moby_Dick.txt | grep Melville"
  expect(output).to match(/Melville/)
end

Given('that one of the disks has failed') do
  @zfs.damage_drive "md0"
  @vagrant.exec "sudo zpool scrub testpool"
  output = @vagrant.exec "zpool status testpool"
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
  @zfs.create_drive("md3", "1TB")
  @vagrant.exec "sudo zpool replace testpool /dev/md0 /dev/md3"
end

Then('my files are all still available') do
  output = @vagrant.exec "zpool status testpool"
  expect(output).to match(/state: ONLINE/)
  output = @vagrant.exec "cat /testpool/data/Moby_Dick.txt | grep Melville"
  expect(output).to match(/Melville/)
end

Given('that new larger drives are connected') do
  @start_size = @vagrant.exec "zpool list | grep testpool | awk '{ print $2 }'"
  @zfs.create_drive("md4", "2TB")
  @zfs.create_drive("md5", "2TB")
  @zfs.create_drive("md6", "2TB")
end

When('the drives are replaced one at a time') do
  @vagrant.exec "sudo zpool replace testpool /dev/md0 /dev/md4"
  @vagrant.exec "sudo zpool replace testpool /dev/md1 /dev/md5"
  @vagrant.exec "sudo zpool replace testpool /dev/md2 /dev/md6"
  @vagrant.exec "sudo zpool online -e testpool /dev/md4"
  @vagrant.exec "sudo zpool online -e testpool /dev/md5"
  @vagrant.exec "sudo zpool online -e testpool /dev/md6"
end

Then('my zpool has more storage available') do
  @new_size = @vagrant.exec "zpool list | grep testpool | awk '{ print $2 }'"
  expect(@new_size).not_to eq @start_size
end

Given('that a snapshot has been made') do
  @vagrant.exec "sudo zfs snapshot testpool@test"
end

When('a file has been deleted') do
  @vagrant.exec "sudo rm /testpool/data/Moby_Dick.txt"
  output = @vagrant.exec "ls /testpool/data/"
  expect(output).not_to match(/Moby_Dick\.txt/)
end

When('I restore from the snapshot') do
  @vagrant.exec "sudo cp /testpool/.zfs/snapshot/test/data/Moby_Dick.txt /testpool/data/Moby_Dick.txt"
end
