require "rspec"

Given('that I am writing a test') do
  @num = 1
end

When('I run my test') do
  @expected = 1
end

Then('I see green') do
  expect( @num ).to eq @expected
end
