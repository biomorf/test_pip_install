#!/usr/bin/env sh


linux_packages() {
### with Linux Package Managers
### https://packaging.python.org/en/latest/guides/installing-using-linux-tools/

# if [ $(lsb) == "ubuntu" ]; then
sudo apt-get update \
  && sudo apt-get install --yes python3-pip
#fi

python3 -m pip install --upgrade pip setuptools wheel
#echo "export PATH='/home/$USER/.local/bin':$PATH" 
python3 -m pip install --upgrade virtualenv
}


pip_packages() {
### https://packaging.python.org/en/latest/tutorials/installing-packages/#installing-requirements
curl -s https://bootstrap.pypa.io/get-pip.py \
  | sudo python3 \
  && python3 -m pip install --upgrade virtualenv
}

pip_packages
#linux_packages
