
# update system
update:
  sudo apt-get -y update && sudo apt-get -y upgrade && sudo snap refresh

# basic machine provisioning 
machine-prov:
  #!/usr/bin/env bash
  echo "export PATH=~/.cargo/bin:$PATH" >> ~/.bashrc
  sudo apt-get update
  sudo apt-get upgrade
  sudo apt-get install tmux ranger
  sudo snap install nvim 
  sudo snap install rustup --classic
  cargo install gitui --locked


