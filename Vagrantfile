Vagrant.configure("2") do |config|
  config.vm.define "master" do |master|
    master.vm.box = "hashicorp/precise64"
    master.vm.network "private_network", ip: "192.168.100.100"
    master.vm.hostname = "master"
    master.vm.provision "shell", path: "prepare.sh"
    master.vm.provision "shell", inline: "sudo apt-get -y install salt-master"
    master.vm.provision "shell", path: "post.sh"
  end

  MINION_COUNT = 2

  (1..MINION_COUNT).each do |minion_id|
    config.vm.define "minion#{minion_id}" do |minion|
      minion.vm.box = "hashicorp/precise64"
      minion.vm.network "private_network", ip: "192.168.100.#{minion_id + 100}"
      minion.vm.hostname = "minion#{minion_id}"
      minion.vm.provision "shell", path: "prepare.sh"
      minion.vm.provision "shell", inline: "sudo apt-get -y install salt-minion"
      minion.vm.provision "shell", inline: "sudo echo 'master: 192.168.100.100' >> /etc/salt/minion"
      minion.vm.provision "shell", path: "post.sh"
      minion.vm.provision "shell", inline: "sudo salt-minion -d"
    end
  end
end
