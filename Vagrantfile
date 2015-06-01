Vagrant.configure("2") do |config|
 
  config.vm.box = "directusdemo"
  config.vm.box_url = "http://demo.getdirectus.com/directus-0.1.0.box"
  config.vm.network "private_network", ip: "192.168.33.6"
  config.vm.hostname = "directusdemo"
 
  config.vm.provision :shell, path: "bootstrap.sh"
 
  config.vm.synced_folder "public/", "/var/www/directus/public", :mount_options => ["dmode=777", "fmode=666"]
 
end
