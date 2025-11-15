require "rspec"
require "vagrant"

Given('3 disks with 4k physical sectors are attached') do
  @zfs = ZfsFixture.new
  pending # Write code here that turns the phrase above into concrete actions
end

When('a zpool called zdata with a raidz1 vdev using those disks') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('is created with the {string} option') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('the zdata pool has an ashift value of {int}') do |int|
# Then('the zdata pool has an ashift value of {float}') do |float|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('has a raidz1 vdev with {int} providers') do |int|
# Then('has a raidz1 vdev with {float} providers') do |float|
  pending # Write code here that turns the phrase above into concrete actions
end
