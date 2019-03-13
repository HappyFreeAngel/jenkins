#!/bin/bash
#虚拟环境及其激活和正确的使用方式:
ANSIBLE_VERSION="2.6.10" #2.7.8
PYTHON_VERSION="3.7"
mkdir ansible${ANSIBLE_VERSION}_python${PYTHON_VERSION}
cd ansible${ANSIBLE_VERSION}_python${PYTHON_VERSION}
#easy_install pip

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py

#安装虚拟环境
sudo pip3 install virtualenv

#
sudo virtualenv -p /usr/bin/python3.7 venv
#sudo python3 -m venv venv
#virtualenv -p python2 venv #可以指定python版本python2 virtualenv -p python3 venv #可以指定python版本 python3 #python3 -m venv venv source venv/bin/activate
#列出哪些ansible是可以通过pip安装的 
pip install ansible==
sudo pip3 install ansible==${ANSIBLE_VERSION}
