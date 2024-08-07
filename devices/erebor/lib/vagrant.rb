require "open3"

class VagrantStatus
  attr_reader :state

  def initialize(state)
    @state = state
  end

  # vagrant status --machine-readable
  # 1721851780,erebor,state,not_created
  def self.newFromString(vagrant_status_output)
    state = "unknown"
    vagrant_status_output.each_line do |line|
      lineArray = line.split(",")
      if lineArray[2] == "state"
        state = lineArray[3].strip
      end
    end
    VagrantStatus.new(state)
  end
end

class Vagrant
  def status
    cmd = "vagrant status erebor --machine-readable"
    VagrantStatus.newFromString(run_cmd_or_exit(cmd).strip)
  end

  def exec(command_arg)
    cmd = "ssh -F ./ssh_config erebor -- #{command_arg}"
    run_cmd_or_exit(cmd).strip
  end

  def scp(src, dst)
    cmd = "scp -F ./ssh_config #{src} erebor:#{dst}"
    run_cmd_or_exit(cmd).strip
  end

  def dump(cmd, exit_code, stdout, stderr)
    puts "Something bad happened, dumping context"
    puts "Cmd: #{cmd}"
    puts "ExitCode: #{exit_code}"
    puts "Stdout: \n#{stdout.read}"
    puts "Stderr: \n#{stderr.read}"
    exit exit_code
  end

  def run_cmd_or_exit(cmd)
    Open3.popen3(cmd) do |stdin, stdout, stderr, thread|
      exit_code = thread.value.exitstatus
      if exit_code != 0
        dump(cmd, exit_code, stdout, stderr)
      end
      stdout.read
    end
  end
end
