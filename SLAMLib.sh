#!/bin/bash

echo "SLAM Common Library Install"

echo "g2o Install...."

echo "Dependencies Install"

sudo apt-get install libsuitesparse-dev qtdeclarative5-dev qt5-qmake libqglviewer-dev-qt5

wget https://github.com/RainerKuemmerle/g2o/archive/refs/tags/20201223_git.tar.gz

tar -zxvf g2o-20201223_git.tar.gz

cd g2o-20201223_git

mkdir build

cd build

cmake ..

make -j12

sudo make install 

echo "g2o Install Success"

cd ../..

echo "Pangolin Install"

git clone --recursive https://github.com/stevenlovegrove/Pangolin.git

cd Pangolin 

./scripts/install_prerequisites.sh --dry-run recommended

mkdir build && cd build
cmake ..
cmake --build .

sudo make install

cd ../..

echo "Pangolin Install Success"

echo "Ceres Solver Install"

wget http://ceres-solver.org/ceres-solver-2.0.0.tar.gz

sudo apt-get install cmake

sudo apt-get install libgoogle-glog-dev libgflags-dev

sudo apt-get install libatlas-base-dev

sudo apt-get install libeigen3-dev

sudo apt-get install libsuitesparse-dev

tar zxf ceres-solver-2.0.0.tar.gz

mkdir ceres-bin

cd ceres-bin

cmake ../ceres-solver-2.0.0

make -j8

make test

sudo make install

cd ../..

echo "Ceres Solver Install Success"

