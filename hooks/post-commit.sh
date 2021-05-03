#!/usr/bin/env bash

CREATE_CHANGE_FILE=".create-change"

if [ -e $CREATE_CHANGE_FILE ]; then
  msg=`cat $CREATE_CHANGE_FILE`
  rm $CREATE_CHANGE_FILE

  type=""

  shopt -s nocasematch
  if [[ "$msg" =~ \[PATCH\] ]]; then type="patch"; 
  elif [[ "$msg" =~ \[MINOR\] ]]; then type="minor"
  elif [[ "$msg" =~ \[MAJOR\] ]]; then type="major"; fi
  shopt -u nocasematch

  
  if [[ "$type" == "patch" || "$type" == "minor" || "$type" == "major" ]]; then 
    shopt -s nocasematch
    fixed="${msg}"
    fixed="${fixed//\[PATCH\]}"
    fixed="${fixed//\[MINOR\]}"
    fixed="${fixed//\[MAJOR\]}"
    fixed=`echo "$fixed" | sed 's/ *$//g' | sed 's/^ *//g'`
    shopt -u nocasematch
    
    echo "Adding semversioner change"
    semversioner add-change --type "$type" --description "$fixed"
    git add $PWD/.changes/next-release/*
    git commit --amend --no-verify -m "$fixed"
  fi

fi
