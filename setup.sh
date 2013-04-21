#! /usr/bin/env bash

for dir in $(ls -d ~/dotfiles/*/)
do
  echo "running ${dir}setup.sh"
  "${dir}setup.sh"
done
