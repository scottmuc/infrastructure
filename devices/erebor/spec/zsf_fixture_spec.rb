require "rspec"

class ZfsFixture
  def create_drive(name)
    Vagrant.new.exec "truncate -s 1TB #{name}"
    Vagrant.new.exec "sudo mdconfig -u #{name} -f #{name}"
  end

  def delete_drive(name)
    Vagrant.new.exec "sudo mdconfig -du #{name}"
    Vagrant.new.exec "rm #{name}"
  end
end

describe ZfsFixture do
  it "creates fake 1TB drives and deletes them" do
    ZfsFixture.new.create_drive "md0"

    output = Vagrant.new.exec "ls -lah md0"
    expect(output).to match(/1.0T/)

    output = Vagrant.new.exec "sudo diskinfo -v /dev/md0"
    expect(output).to match(/1.0T/)

    ZfsFixture.new.delete_drive "md0"
    output = Vagrant.new.exec "sudo mdconfig -l"
    expect(output).to eq ""

    output = Vagrant.new.exec "ls"
    expect(output).to eq ""
  end
end
