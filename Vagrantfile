# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = 'win2012r2chef'

  config.vm.guest = :windows
  config.vm.hostname = 'Windoze'
  config.vm.communicator = 'winrm'

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider 'virtualbox' do |vb|
    vb.gui = false

    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ['modifyvm', :id, '--memory', '2048']
    # use the Paravirtualised network adaptor
    # vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
    # use ICH9 for the chipset
    vb.customize ['modifyvm', :id, '--chipset', 'ich9']
    # add a dvd drive to the first IDE controller
    vb.customize ['storageattach', :id, '--storagectl', 'IDE Controller',
                  '--port', '0', '--device', '0', '--type', 'dvddrive',
                  '--medium', 'emptydrive']
    vb.name = config.vm.hostname
    vb.cpus = 4
  end

  config.vm.provider :aws do |aws, override|
    aws.access_key_id = ENV['AWS_ACCESS_KEY_ID']
    aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    aws.session_token = ENV['AWS_SESSION_TOKEN']
    aws.keypair_name = ENV['AWS_SSH_KEY_ID']

    aws.region = 'ap-southeast-2'
    aws.availability_zone = 'ap-southeast-2a'
    aws.instance_type = 't2.micro'
    # aws.vpc_id = 'vpc-deadbeef'
    aws.subnet_id = 'subnet-f00dcafe'
    aws.associate_public_ip = true
    aws.security_groups = ['sg-71077345']
    aws.iam_instance_profile_name = 'ITS-ChefNode'
    aws.ami = 'ami-db0a2db8'
    aws.user_data = 'files/user_data.txt'

    override.vm.box = 'dummy'
    override.winrm.username = 'Administrator'
  end

  # Ensure this version of Chef is installed
  config.omnibus.chef_version = '12.7.2'

  # Berkshelf configuration
  config.berkshelf.enabled = true

  config.ssh.forward_agent = true

  # Chef configuration
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = '..'
    chef.log_level = 'info'
    chef.add_recipe 'windows-services'
  end
end
