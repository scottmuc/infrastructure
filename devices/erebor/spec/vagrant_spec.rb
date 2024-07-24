require "rspec"
require "vagrant"
require "vagrant_status"

describe VagrantStatus do
  it "extracts state from machine readable output" do
    vagrant_status_output = %{
      _,_,_,_
      _,_,state,the_state
      _,_,_,_
    }

    vagrant_status = VagrantStatus.newFromString vagrant_status_output
    expect(vagrant_status.state).to eq "the_state"
  end
end

describe Vagrant do
  # This needs to run before any other attempt to run commands against
  # the FreeBSD VM.
  before(:all) do
    vagrant_status = Vagrant.new.status
    expected_state = "running"
    expect(vagrant_status.state).to eq expected_state
  end

  it "can run commands inside the VM" do
    exec_stdout = Vagrant.new.exec "whoami"
    expected_stdout = "vagrant"
    expect(exec_stdout).to eq expected_stdout
  end
end
