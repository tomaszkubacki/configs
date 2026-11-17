
# update system
update:
  sudo apt-get -y update && sudo apt-get -y upgrade && sudo snap refresh

# basic machine provisioning 
machine-prov:
  #!/usr/bin/env bash
  sudo apt-get update
  sudo apt-get upgrade
  sudo apt-get install tmux nvim ranger
  sudo snap install rustup --classic
  cargo install gitui --locked


