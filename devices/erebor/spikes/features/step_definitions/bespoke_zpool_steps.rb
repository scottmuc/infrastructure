require "rspec"
require "vagrant"

Given('3 disks with 4k physical sectors are attached') do
  @vagrant = Vagrant.new
  @zfs = ZfsFixture.new
  @zfs.create_drive("md0", "1TB")
  @zfs.create_drive("md1", "1TB")
  @zfs.create_drive("md2", "1TB")
end

When('a zpool called {string} with a raidz1 vdev using those disks') do |zpool|
  @zpool_name = zpool
end

When('is created with the {string} option') do |zpool_option|
  @zfs.create_zpool(@zpool_name, "/dev/md0 /dev/md1 /dev/md2")
end

Then('the zdata pool has an ashift value of {int}') do |expected_ashift|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('has a raidz1 vdev with {int} providers') do |expected_provider_count|
  pending # Write code here that turns the phrase above into concrete actions
end
