#!/usr/bin/env bash

CREATE_CHANGE_FILE=".create-change"

msg=`cat $1`

shopt -s nocasematch
if [[ "$msg" =~ \[(PATCH|MINOR|MAJOR)\] ]]; then
  change_requested="yes"
fi
shopt -u nocasematch

if [[ $change_requested ]]; then
  cp -f $1 $CREATE_CHANGE_FILE
fi
