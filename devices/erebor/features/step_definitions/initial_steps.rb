require "rspec"
require "vagrant"

class ZfsFixture
  def create_drive(name)
    Vagrant.new.exec "truncate -s 1TB #{name}"
    Vagrant.new.exec "sudo mdconfig -u #{name} -f #{name}"
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

And('it contains some data') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('that one of the disks has failed') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('the failed disk is replaced') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('my files are all still available') do
  pending # Write code here that turns the phrase above into concrete actions
end
