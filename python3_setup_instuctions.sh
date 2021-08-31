#!/usr/bin/env bash

mkdir -p ~/python3_ws/src

cd python3_ws

sudo apt-get install python3-pip python-catkin-tools python3-dev python3-numpy
#make sure it is using the python 3
pip3 install virtualenv

python3 -m virtualenv py3env --python=python3

source ~/python3_ws/py3env/bin/activate

cd ~/python3_ws/src

git clone https://github.com/ros/geometry
git clone https://github.com/ros/geometry2
git clone https://github.com/cra-ros-pkg/robot_localization

#https://index.ros.org/d/geographiclib/
sudo apt-get install libgeographic-dev

pip3 install pyaml empy rospkg

cd ~/python3_ws

catkin build -DPYTHON_EXECUTABLE:FILEPATH=/home/nvidia/python3_ws/py3env/bin/python

source ~/python3_ws/devel/setup.bash

echo "#!/usr/bin/env bash

source ~/python3_ws/py3env/bin/activate
source ~/python3_ws/devel/setup.bash" > ~/python3_ws/workspace_setup.bash


#PyTroch
# to find all the latest version look here https://forums.developer.nvidia.com/t/pytorch-for-jetson-version-1-9-0-now-available/72048 be sure to have the correct URL for the version desired
wget https://nvidia.box.com/shared/static/h1z9sw4bb1ybi0rm3tu8qdj8hs05ljbm.whl -O torch-1.9.0-cp36-cp36m-linux_aarch64.whl
sudo apt-get install python3-pip libopenblas-base libopenmpi-dev  
pip3 install Cython numpy tensorboard
pip3 install torch-1.9.0-cp36-cp36m-linux_aarch64.whl

#For numpy to work correctly and not crash add this as environmental variable
#export OPENBLAS_CORETYPE=ARMV8
echo "export OPENBLAS_CORETYPE=ARMV8" | sudo tee -a /etc/environment

#To verify installation

python
import torch

#If the import fail and causes Python to crash make sure to look in the details section and look in the the "UnreportableReseason" section for what the problem is

rm torch-1.9.0-cp36-cp36m-linux_aarch64.whl



