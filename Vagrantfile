Vagrant.configure("2") do |config|
  config.vm.box = "ol7"
  config.vm.box_url = "https://yum.oracle.com/boxes/oraclelinux/latest/ol7-latest.box"

  config.vm.provision "shell", path: "scripts/install_instantclient.sh"
  config.vm.provision "shell", path: "scripts/install_devtools.sh"
  config.vm.provision "shell", path: "build.sh"

end
