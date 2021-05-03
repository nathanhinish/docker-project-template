#!/usr/bin/env bash

files=`find hooks -type file`

for file in $files; do
  temp=${file//hooks\/}
  hook_name=${temp//\.sh}
  echo "Linking $hook_name..."
  rm -rf .git/hooks/$hook_name
  ln -s $PWD/hooks/$hook_name.sh .git/hooks/$hook_name
done
