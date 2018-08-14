#!/bin/bash

github_rqqepositories_url='https://github.com/YuYuCong/BlogImg.git'
github_user='YuYuCong'
github_pwd=''

if [ ! -d ~/Pictures/blogimg ]; then
    mkdir ~/Pictures/blogimg
fi

cd ~/Pictures/blogimg

if [ ! -d ./.git ];then
    git init
    git remote add origin $github_rqqepositories_url
fi

shutter -s -e -o '~/Pictures/blogimg/%y%m%d-%T.png'

git add -A
git commit -m "addnewimg"

/usr/bin/expect <<EOF
set timeout 20
spawn git push -u origin master
expect "Username" 
send "$github_user\r"
expect "Password" 
send "$github_pwd\r"
expect "set up"
send "Done!"
EOF











