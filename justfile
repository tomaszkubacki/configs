set dotenv-load

# disply this help
help:
  just --list

# shutdowns computer
get_off:
  shutdown -h now

# suspend laptop
suspend:
  systemctl suspend

# update system
update:
  sudo apt-get update && sudo apt-get upgrade 

# send file to www
[no-cd]
send_www file:
  #!/usr/bin/env bash
  full_path=`pwd`/{{file}}
  rsync -arvtP -e 'ssh -p $WWW_PORT' $full_path $WWW_USER@$WWW_IP:/web/htdocs/www.${WWW_HOST}/home/www/files

# file list www
[no-cd]
www_files:
  #!/usr/bin/env bash
  ssh $WWW_USER@$WWW_IP -p $WWW_PORT -t "cd /web/htdocs/www.${WWW_HOST}/home/www/files; ls" | xargs -I {} echo "https://${WWW_HOST}/files/{}"

# backup data to remote server
backup:
    rsync -arvtP -e 'ssh -p $WWW_PORT' --delete ~/to_backup/* $WWW_USER@$WWW_IP:~/backup-moocode/

# list jdks
[group("jdk")]
jdks:
     update-java-alternatives --list


