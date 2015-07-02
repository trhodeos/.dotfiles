#!/bin/bash

set -e

for f in *.symlink; do
  filepath=$(realpath $f)
  linkpath=$HOME/.${f%.*}
  if [[ -e $linkpath ]]; then
    backuppath=$linkpath.$(date +%F.%T)
    read -r -p "$linkpath already exists. Overwrite? [y/N] " response
    if [[ "$response" != "y" ]]; then
      echo Skipping $linkpath
      continue
    fi
    echo Backing up $linkpath to $backuppath
    mv $linkpath $backuppath
  fi
  echo Linking $filepath to $linkpath
  ln -s $filepath $linkpath
done
