require "vagrant"

class ZfsFixture
  def initialize
    @vagrant = Vagrant.new
  end

  def create_drive(name, size)
    @vagrant.exec "truncate -s #{size} #{name}"
    @vagrant.exec "sudo mdconfig -u #{name} -f #{name} || true"
  end

  def damage_drive(name)
    @vagrant.exec "dd if=/dev/zero of=#{name} bs=4M count=1"
  end

  def delete_drive(name)
    @vagrant.exec "sudo mdconfig -du #{name} || true"
    @vagrant.exec "rm -f #{name}"
  end

  def create_zpool(name, options, drives)
    @vagrant.exec "sudo zpool create #{options} #{name} raidz1 #{drives}"
  end

  def delete_zpool(name)
    @vagrant.exec "sudo zpool destroy #{name} 2> /dev/null"
  end
end

