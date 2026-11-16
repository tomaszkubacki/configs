# backup obsidian
backup-obs msg = "feat: backup":
    #!/bin/bash
    cd Dokumenty/Obsidian\ Vault/
    git add .
    git commit -m "{{msg}}"
    git push

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
  rclone copy $full_path moocode:www/files
  target_url=https://${WWW_HOST}/files/{{file}}
  echo '{{BOLD + CYAN + BG_BLACK}}'$target_url'{{NORMAL}}'
  echo $target_url | wl-copy


# list files in on moocode site at /files
[no-cd]
browse_files:
  #!/usr/bin/env bash
  rclone ncdu moocode:www/files

# backup data to remote server
backup: 
  #!/usr/bin/env bash
  echo '~/to_backup dir backup'
  rclone copy ~/to_backup moocode:backup --progress

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

# wg vpn up
wg_up name:
   sudo wg-quick up {{name}}

# wg vpn down
wg_down name:
   sudo wg-quick down {{name}}

# list wg connection
wg_list:
   sudo ls /etc/wireguard/


