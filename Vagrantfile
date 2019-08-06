Vagrant.configure("2") do |config|
  config.vm.box = "ol7"
  config.vm.box_url = "https://yum.oracle.com/boxes/oraclelinux/latest/ol7-latest.box"
  config.vm.network "private_network", ip: "192.168.56.20"

  config.vm.provision "shell", path: "scripts/install_instantclient.sh"
  config.vm.provision "shell", path: "scripts/install_devtools.sh"

  # consul
  config.vm.network "forwarded_port", guest: 8500, host: 8500
  config.vm.provision "shell", env: { "IFACE" => "eth1"},
    path: "https://raw.githubusercontent.com/kikitux/curl-bash/master/consul-1server/consul.sh"

  # vault
  config.vm.network "forwarded_port", guest: 8200, host: 8200
  config.vm.provision "shell", env: { "IFACE" => "eth1"},
    path: "https://raw.githubusercontent.com/kikitux/curl-bash/master/vault-dev/vault.sh"

  config.vm.provision "shell", path: "build.sh"

end
