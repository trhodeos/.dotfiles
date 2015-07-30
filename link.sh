#!/bin/bash

set -e

scriptdir=$(dirname "${BASH_SOURCE[0]}")

for f in $scriptdir/*.symlink; do
  filename=$(basename $f)
  filepath=$(cd $(dirname $f) && pwd -P)/$filename
  linkpath=$HOME/.${filename%.*}
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
