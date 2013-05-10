Vagrant.configure("2") do |config|
  config.vm.box = "precise64"

  config.vm.provider :aws do |aws, override|
    config.vm.box = "dummy"

    aws.access_key_id = IO.read("config/access_key").chomp
    aws.secret_access_key = IO.read("config/secret_key").chomp
    aws.keypair_name = IO.read("config/key_name").chomp
    
    aws.instance_type = "m1.large"
    aws.ami = "ami-7747d01e"
    aws.tags = {
      "Name" => "Metron",
      "Owner" => ENV["USER"]
    }

    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = "config/identity.pem"
  end

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe "apt"
    chef.add_recipe "graphite"
  end

  config.omnibus.chef_version = "11.4.0"
  config.berkshelf.enabled = true
end
