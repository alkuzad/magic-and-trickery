#!/bin/bash

# Author - Dawid Goslawski
# Small helper to install all scripts to bin folder
# TODO - selective installation ? Quite easy based on echo/read

BIN_FOLDER="$HOME/bin/magic_and_trickery"

if [[ ! -d "$BIN_FOLDER" ]];then
  mkdir -p "$BIN_FOLDER"
else
  echo "$BIN_FOLDER already exists - recreate ? y/n"
  read -ers -n1 resp
  if [[ "$resp" =~ [yY] ]];then
    rm -rf "$BIN_FOLDER"
    mkdir -p "$BIN_FOLDER"
  else
    echo "Continue without recreation ? y/n"
    read -ers -n1 resp
    if [[ ! "$resp" =~ [yY] ]];then
      echo "Bye then"
      exit 1
    fi
  fi
fi

(find ./ -not -wholename "*/.git/*" -type f -not -name "*.*") | while read f;do
ln -s "$(readlink -f $f)" "$BIN_FOLDER/"
done

echo "Add $BIN_FOLDER to PATH (on the end of .bashrc) y/n?"
read -ers -n1 resp
if [[ "$resp" =~ [yY] ]];then
  echo "export PATH=\$PATH:$BIN_FOLDER" >> ~/.bashrc
fi
