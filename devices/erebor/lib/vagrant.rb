require "open3"

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

  def exec(command_arg)
    Open3.popen3("vagrant", "ssh", "--no-tty", "--", command_arg) do |stdin, stdout, stderr, thread|
      exit_code = thread.value.exitstatus
      if exit_code != 0
        dump(exit_code, stdout, stderr)
      end
      stdout.read.strip
    end
  end
end
