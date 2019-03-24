#!/bin/bash

pwd
if [ -f CMakeLists.txt ];then
    if [ ! -d ./build ];then
    mkdir ./build
    fi

    cd ./build
    cmake ..
    make
    ls
else
echo "Can not find CMakeLists.txt"
fi
