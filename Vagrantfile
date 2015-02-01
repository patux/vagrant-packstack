# -*- mode: ruby -*-
# vi: set ft=ruby :

map = {
    'cpu' => '2',
    'memory' => '4096',
}
Vagrant.configure(2) do |config|
  config.vm.box = "chef/centos-7.0"

  vm_name = 'centos7'
  config.vm.define vm_name do |c|
    c.vm.host_name = vm_name
    c.vm.network 'private_network', ip: '192.168.100.11' # eth1
    c.vm.network 'private_network', ip: '192.168.200.11' # eth1
    #c.vm.network 'private_network', ip: '192.168.200.11' # eth2
  end

  config.vm.provider 'virtualbox' do |v|
    v.customize ['modifyvm', :id, '--cpus', map['cpu']]
    v.customize ['modifyvm', :id, '--memory', map['memory']]
  end
  config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  config.vm.provision :shell, :path => "packstack.sh"

end
