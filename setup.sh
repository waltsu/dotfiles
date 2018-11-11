#/bin/bash

function copy_file () {
  if [ -f ~/.$1 ]; then
   echo "$1 exists, creating backup"
   cp -p ~/.$1 ~/.$1_backup
  fi

  ln -sf $(pwd)/$1 ~/.$1
}

copy_file "vimrc"
copy_file "slate"
copy_file "zshrc"
