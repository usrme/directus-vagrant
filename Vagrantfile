Vagrant.configure("2") do |config|
 
  config.vm.box = "directusdemo"
  config.vm.box_url = "http://demo.getdirectus.com/directus-0.0.1.box"
  config.vm.network "private_network", ip: "192.168.33.6"
  config.vm.hostname = "directusdemo"
  config.vm.synced_folder ".", "/var/www", :mount_options => ["dmode=777", "fmode=666"]
 
end
