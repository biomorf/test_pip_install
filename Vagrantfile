# -*- mode: ruby -*-
# vi: set ft=ruby :


$script = <<-SCRIPT
sudo cat > /etc/apt/apt.conf.d/01deb-proxy <<-_EOF_
	#Acquire::http::Proxy \"http://10.0.2.2:8000\";
	#Acquire::http::Proxy \"http://172.17.0.2:3128\";
_EOF_
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.hostname = "ubuntu"

  ############################################################
  # Provider for Docker on Intel or ARM (aarch64)
  ############################################################
  config.vm.provider :docker do |docker, override|
    override.vm.box = nil
    #docker.image = "rofrano/vagrant-provider:ubuntu"
    docker.build_dir = "."
    docker.dockerfile = "Dockerfile.ubuntu"

    docker.remains_running = true
    docker.has_ssh = true
    docker.privileged = true
    docker.volumes = ["/sys/fs/cgroup:/sys/fs/cgroup:rw"]
    #docker.create_args = ["--cgroupns=host"]
    docker.create_args = ["--cgroupns=host", "--mount", "type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock"]
    # Uncomment to force arm64 for testing images on Intel
    # docker.create_args = ["--platform=linux/arm64", "--cgroupns=host"]
    docker.ports = ["3128:3128"]
  end

  config.vm.boot_timeout = 600
  config.vm.synced_folder ".", "/vagrant_data"
  config.vm.synced_folder "../vault", "/vault"

  # Install Docker and pull an image
#   config.vm.provision :docker do |d|
#     d.images = ["docker.io/ubuntu/squid:4.10-20.04_beta"]
#     #d.pull_images "alpine:latest"
#     d.run "proxy.squid.container",
#       image: "docker.io/ubuntu/squid:4.10-20.04_beta",
#       args: "        -e TZ=UTC          -p 3128:3128          ",
#       daemonize: true
#
#         #-v '/vagrant_data:/vagrant' \
#   end

  config.vm.provision "set_proxy", type: "shell", inline: $script
  config.vm.provision "pip", type: "shell", path: "./python3_pip_install.sh"
  config.vm.provision "ansible", type: "shell", path: "./ansible_install.sh"

  config.vm.provision "ansible_local" do |ansible|
    ### https://developer.hashicorp.com/vagrant/docs/provisioning/ansible_local
    ansible.provisioning_path = "/vagrant_data"
    ansible.playbook = "playbook.yml"
    ansible.install = false
    ansible.version = "latest"
    #ansible.install_mode = "default"
    #ansible.install_mode = "pip"
    #ansible.version = "2.2.1.0"
      #ansible.pip_install_cmd = " \
      #  https_proxy=#{PROXY}:#{PROXY_PORT} curl -s https://bootstrap.pypa.io/get-pip.py \
      #  | sudo https_proxy=#{PROXY}:#{PROXY_PORT} python"
  end

  config.vm.provision "ansible_local_b", type: "ansible_local" do |ansible|
    ### https://developer.hashicorp.com/vagrant/docs/provisioning/ansible_local
    ansible.install = false
    ansible.provisioning_path = "/vagrant_data"
    ansible.playbook = "local.yml"
    #ansible.raw_arguments  = "--ask-vault-pass"
    #TODO test
    ansible.vault_password_file = "/vault/vault"
    ansible.become = true
  end
end
