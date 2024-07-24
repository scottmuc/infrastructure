require "rspec"
require "open3"


class VagrantStatus
  attr_accessor :state

  def initialize(state)
    @state = state
  end

  # vagrant status --machine-readable
  # 1721851780,erebor,state,not_created
  def self.newFromString(vagrant_status_output)
    state = ""
    vagrant_status_output.each_line do |line|
      lineArray = line.split(",")
      if lineArray[2] == "state"
        state = lineArray[3].strip
      end
    end
    VagrantStatus.new(state)
  end
end

describe "VagrantStatus" do
  it "assigns state" do
    vagrant_status_output = %{
      _,_,_,_
      _,_,state,slime
      _,_,_,_
    }

    vagrant_status = VagrantStatus.newFromString vagrant_status_output
    expect(vagrant_status.state).to eq "slime"
  end
end

class Vagrant
  def dump(exit_code, stdout, stderr)
    puts "Something bad happened, dumping context"
    puts "ExitCode: #{exit_code}"
    puts "Stdout: \n#{stdout.read}"
    puts "Stderr: \n#{stderr.read}"
    exit exit_code
  end

  def status
    Open3.popen3("vagrant", "status", "erebor", "--machine-readable") do |stdin, stdout, stderr, thread|
      exit_code = thread.value.exitstatus
      if exit_code != 0
        dump(exit_code, stdout, stderr)
      end
      VagrantStatus.newFromString stdout.read
    end
  end
end

describe "Vagrant" do
  it "fails fast if vagrant VM isn't running" do
    vagrant_status = Vagrant.new.status
    expected_state = "running"
    expect(vagrant_status.state).to eq expected_state
  end
end
