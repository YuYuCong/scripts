#!/bin/bash

github_repositories_url='https://github.com/YuYuCong/BlogImg.git'
github_user='YuYuCong'
github_pwd='不告诉你'

if [ ! -d ~/bin ];then
    mkdir ~/bin
fi

if [ ! -f ~/bin/blogimgshot.sh ];then
cp -r blogimgshot.sh ~/bin
fi

if [ ! -d ~/Pictures/blogimg ]; then
    mkdir ~/Pictures/blogimg
fi

cd ~/Pictures/blogimg

if [ ! -d ./.git ];then
    git init
    git remote add origin $github_repositories_url
fi

shutter -s -e -o '~/Pictures/blogimg/%y%m%d-%T.png'

filename=`ls -t |awk 'NR==1 {print $NF}'`
imgurl="!["$filename"]("${github_repositories_url%.git}/blob/master/${filename}"?raw=true)"
echo $imgurl |xsel -i -b

git add -A
git commit -m "addimg"

/usr/bin/expect <<EOF
set timeout 20
spawn git push -u origin master
expect "Username" 
send "$github_user\r"
expect "Password" 
send "$github_pwd\r"
expect "set up"
spawn echo "Done!"
EOF