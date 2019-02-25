#!/bin/bash

#step 1 Use the following command to install prerequisites for Python before installing it.

apt-get install -y build-essential checkinstall
apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev \
    libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev
#Step 2 – Download Python 3.7
#Download Python using following command from python official site. You can also download latest version in place of specified below.
cd /usr/src
wget https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz

#Now extract the downloaded package.
tar xzf Python-3.7.2.tgz

#Step 3 – Compile Python Source
#Use below set of commands to compile Python source code on your system using altinstall.

cd Python-3.7.2
 ./configure --enable-optimizations
 make altinstall
#make altinstall is used to prevent replacing the default python binary file /usr/bin/python.

#Step 4 – Check Python Version
#Check the latest version installed of python using below command
ln -s /usr/local/bin/python3.7 /usr/local/bin/python3
ln -s /usr/local/bin/python3.7 /usr/bin/python3
python3.7 -V
python3 -V
