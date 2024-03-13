#!/bin/bash

source $(which msg.sh)

if [[ -z $1 ]]; then
    msg "I need a branch name to archive"
fi

msg "Archiving Branch $1"

set -x
set -e

git stash
git fetch
git checkout $1
git tag archive/branch-$1
git push origin --tags

git checkout master
git branch -d $1
git push origin :"$1"
