require "open3"

class Vagrant
  def dump(cmd, exit_code, stdout, stderr)
    puts "Something bad happened, dumping context"
    puts "Cmd: #{cmd}"
    puts "ExitCode: #{exit_code}"
    puts "Stdout: \n#{stdout.read}"
    puts "Stderr: \n#{stderr.read}"
    exit exit_code
  end

  def status
    cmd = "vagrant status erebor --machine-readable"
    Open3.popen3(cmd) do |stdin, stdout, stderr, thread|
      exit_code = thread.value.exitstatus
      if exit_code != 0
        dump(cmd, exit_code, stdout, stderr)
      end
      VagrantStatus.newFromString stdout.read
    end
  end

  def exec(command_arg)
    cmd = "vagrant ssh --no-tty -- #{command_arg}"
    Open3.popen3(cmd) do |stdin, stdout, stderr, thread|
      exit_code = thread.value.exitstatus
      if exit_code != 0
        dump(cmd, exit_code, stdout, stderr)
      end
      stdout.read.strip
    end
  end
end
