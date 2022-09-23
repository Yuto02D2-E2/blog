#! /bin/sh

set -eu

function colorPrint() {
  case "$1" in
  "blue" ) printf "\e[34m$2\e[m";;
  "green" ) printf "\e[32m$2\e[m";;
  "red" ) printf "\e[31m$2\e[m";;
  esac
}

function make() {
  read -p "> enter post title:" title
  set -x
  hugo new "posts/$(date '+%Y-%m-%d')/$title/index.md" --editor="code"
  set +x
}

function update() {
  set -x
  # git submodule update --remote --merge
  git add content/* --verbose
  git commit -m "[update] content/* @($(date '+%Y/%m/%d-%H:%M:%S'))"
  git push -u origin main
  set +x
}

while true
do
  read -p "> select mode [make|update|exit]:" mode
  if [ "$mode" = "make" ]; then
    make
    break
  elif [ "$mode" = "update" ]; then
    update
    break
  elif [ "$mode" = "exit" ]; then
    echo -e "> ok. exit script"
    break
  else
    colorPrint "red" "> sorry, entered mode($mode) is none\n"
    continue
  fi
done
