# backup obsidian
backup-obs msg = "feat: backup":
    #!/bin/bash
    cd Dokumenty/Obsidian\ Vault/
    git add .
    git commit -m "{{msg}}"
    git push
    

# shutdowns computer
get_off:
  shutdown -h now

# suspend laptop
suspend:
  systemctl suspend

# paste text to pastebin
paste file:
  #!/usr/bin/env bash
  echo " "
  curl -X POST -F api_dev_key=$PASTEBIN_KEY -F "api_paste_code=<{{file}}" -F "api_option=paste" "https://pastebin.com/api/api_post.php" >> last_paste.txt

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

# set jdk version
[group("jdk")]
jdk jdk_version:
    sudo update-java-alternatives --set {{jdk_version}}

# test kolorków
@foo:
  echo '{{BOLD + STRIKETHROUGH + CYAN + BG_RED}}Hi!{{NORMAL}} tomek'

# copy entry from priv/bk/key
bk key:
    pass priv/bk/{{key}} -c

# wg vpn up
wg_up name:
   sudo wg-quick up {{name}}

# wg vpn down
wg_down name:
   sudo wg-quick down {{name}}

# list wg connection
wg_list:
   sudo ls /etc/wireguard/


