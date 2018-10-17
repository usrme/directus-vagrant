Vagrant.configure("2") do |config|

    config.vm.box = "getdirectus/directus"
    config.vm.box_version = "0.2.1"
    config.vm.network "private_network", ip: "192.168.33.6"
    config.vm.hostname = "directusdemo"

    config.vm.provider :virtualbox do |v|
        v.customize [ "modifyvm", :id, "--memory", 1024 ]
    end

    # Leave empty for latest release or use specific
    # version number for release (e.g. '6.4.9')
    project_version='6.4.9'
    config.vm.provision :shell, path: "bootstrap.sh", :args => project_version
    config.vm.synced_folder "html/", "/var/www/html", :mount_options => ["dmode=777", "fmode=666"]
end
