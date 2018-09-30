#!/bin/bash

path_to_ros_ws='~/code/ros/laser_ws/src' #填入你的ROS_ws/src路径

cd ~
if [ ! -d ${path_to_ros_ws#*~/} ];then
    mkdir -p ${path_to_ros_ws#*~/}
fi

cd $path_to_ros_ws
git clone  https://github.com/ros/genmsg.git
cd genmsg
mkdir build
cd build
cmake ..
make
make install

cd $path_to_ros_ws
mkdir hokuyo
cd hokuyo
git clone https://github.com/ros-drivers/driver_common.git
cd driver_common/driver_base
mkdir build
build
cmake ..
make
sudo make install

cd $path_to_ros_ws
cd hokuyo/driver_common/driver_common
mkdir build
cd build
cmake ..
make
sudo make install

cd $path_to_ros_ws
cd hokuyo/driver_common/timestamp_tools
mkdir build
cd build
cmake ..
make
sudo make install

cd $path_to_ros_ws
cd hokuyo
git clone https://github.com/ros-perception/laser_proc.git
git clone https://github.com/ros-drivers/urg_c.git
git clone https://github.com/ros-drivers/hokuyo_node.git

cd laser_proc
mkdir build
cd build
cmake ..
make
sudo make install

cd $path_to_ros_ws
cd hokuyo
cd hokuyo_node
mkdir build
cd build
rosdep install --from-paths ~/code/ros/hokuyo_ws/src --ignore-src
catkin_make - DCATKIN_WHITELIST_PACKAGES="hokuyo_node"

cd $path_to_ros_ws
cd ..
catkin_make install
