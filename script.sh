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
  read -p "> enter post title (e.g. 'helloworld', '01', or..):" title
  hugo new "posts/$(date '+%Y-%m-%d')/$title/index.md" --editor="code"
}

function update() {
  # git submodule update --remote --merge
  git status --short --branch
  git add content/* --verbose
  git commit -m "[update] content/* at ($(date '+%Y/%m/%d-%H:%M:%S')) via script.sh"
  read -p "> successfully committed. want to push? [y|n]:" yn
  if [ "$yn" = "y" ]; then
    git push -u origin main
  fi
  git log --oneline --graph --decorate --numstat -n 5
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
