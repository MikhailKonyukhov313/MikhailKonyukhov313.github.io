#!/bin/bash

git_stash=''
git_add=''
npm_i='npm i'
pm2='pm2 restart all'
start_stg=''

while getopts ":isf" opt; do
    case $opt in
        i) npm_i="" ;;
        s) git_stash="git stash"
        git_add="git add ." ;;
        f) pm2='pm2 stop'
        start_stg='pm run build:stg' ;;
        :) echo 'False' ;;
        \?) echo "Unknown option -$OPTARG" && exit 1 ;;
    esac
    shift
done

$git_stash \
&& \
$git_add \
&& \
git fetch \
&& \
git checkout "$1" \
&& \
git pull \
&& \
$npm_i \
&& \
$pm2 \
&& \
$start_stg
