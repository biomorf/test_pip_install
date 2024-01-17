#!/usr/bin/env sh


linux_packages() {
### with Linux Package Managers
### https://packaging.python.org/en/latest/guides/installing-using-linux-tools/

# if [ $(lsb) == "ubuntu" ]; then
sudo apt-get update \
  && sudo apt-get install --yes ansible ansible-lint
  #&& sudo apt-get install --yes ansible-core
#fi

}


pip_packages() {
### https://packaging.python.org/en/latest/tutorials/installing-packages/#installing-requirements
python3 -m pip install ansible
#python3 -m pip install --user ansible
##OR:
#python3 -m pip install --user ansible-core
##OR:
#python3 -m pip install --user ansible-core==2.12.3

#python3 -m pip install --upgrade --user ansible


python3 -m pip install argcomplete
#python3 -m pip install --user argcomplete

activate-global-python-argcomplete
##OR:
#sudo activate-global-python-argcomplete --user
}

pip_packages
#linux_packages
