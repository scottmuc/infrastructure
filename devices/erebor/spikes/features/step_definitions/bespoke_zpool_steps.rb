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
  @zfs.create_zpool(@zpool_name, zpool_option, "/dev/md0 /dev/md1 /dev/md2")
end

Then('the zdata pool has an ashift value of {int}') do |expected_ashift|
  output = @vagrant.exec "sudo zdb -C #{@zpool_name} | grep ashift"
  expect(output).to match(/ashift: #{expected_ashift}/)
end

Then('has a raidz1 vdev with {int} providers') do |expected_provider_count|
  output = @vagrant.exec "zpool status #{@zpool_name}"
  expect(output).to match(/raidz1-0  ONLINE/)
  device_lines = output.lines.select { |line| line.match(/^\s+md\d+\s+ONLINE/) }
  expect(device_lines.count).to eq(3)
end

Then('the root filesystem of the zdata zpool is not mounted') do
  output = @vagrant.exec "ls /"
  expect(output).to_not match(/#{@zpool_name}/)
end

Given('a zdata zpool according to by bespoke requirements is created') do
  steps %Q{
    Given 3 disks with 4k physical sectors are attached
    When a zpool called "zdata" with a raidz1 vdev using those disks
    And is created with the "-m none -o ashift=12" option
  }
end

When('a new filesystem dataset for mcap') do
  @vagrant.exec "sudo mkdir -p /usr/local/var/mcap"
  @vagrant.exec "sudo zfs create -o atime=off -o mountpoint=/usr/local/var/mcap/store zdata/store"
end

Then('it is mounted at {string}') do |mount_path|
  output = @vagrant.exec "zfs list | grep #{@zpool_name}"
  expect(output).to match(/#{mount_path}/)
end

Then('it has atime set to off') do
  output = @vagrant.exec "zfs get -H atime zdata/store"
  expect(output).to match(/zdata\/store\tatime\toff/)
end
