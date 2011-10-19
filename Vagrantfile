Vagrant::Config.run do |config|
  config.vm.box = "relevance-ubuntu-11.04-server-i386"

  # TODO: Add the S3 URL of the new base box that Mike made.
  # config.vm.box_url = "http://dl.dropbox.com/u/7490647/talifun-ubuntu-11.04-server-i386.box"
  
  config.vm.network "33.33.33.10"

  # Enable provisioning with chef solo, specifying a cookbooks path (relative
  # to this Vagrantfile), and adding some recipes and/or roles.
  #
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]
    chef.add_recipe "apache2"
    chef.add_recipe "graphite"

    # You may also specify custom JSON attributes:
    #   chef.json = { :mysql_password => "foo" }
  end
end
