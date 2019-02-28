
FROM jenkins/jenkins:latest

#version: 20190228
## 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
#deb https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch main contrib non-free
## deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch main contrib non-free
#deb https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch-updates main contrib non-free
## deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch-updates main contrib non-free
#deb https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch-backports main contrib non-free
## deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch-backports main contrib non-free
#deb https://mirrors.tuna.tsinghua.edu.cn/debian-security stretch/updates main contrib non-free
## deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security stretch/updates main contrib non-free

USER root
RUN apt-get install -y apt-transport-https \
&&  echo "\ndeb http://mirrors.ustc.edu.cn stretch/updates main\n" > /etc/apt/sources.list \
&&  echo "\ndeb https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch main contrib non-free"  >> /etc/apt/sources.list \
&&  echo "\ndeb https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list \
&&  echo "\ndeb https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch-backports main contrib non-free" >> /etc/apt/sources.list \
&&  echo "\ndeb https://mirrors.tuna.tsinghua.edu.cn/debian-security stretch/updates main contrib non-free" >> /etc/apt/sources.list \
      && cat /etc/apt/sources.list \
      && apt-get update \
      && apt-get upgrade -y \
      && apt-get install -y apt-utils sudo libltdl-dev sshpass sed vim make \
      && apt-get install -y build-essential checkinstall libreadline-gplv2-dev libncursesw5-dev libssl-dev \
         libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev \
      && rm -rf /var/lib/apt/lists/*

## 安装python3 ansible software如果是目录后面需要添加/
ADD install-python3.sh  /software/
ADD install-ansible.sh  /software/
RUN chmod +x /software/install-python3.sh && chmod +x /software/install-ansible.sh \
  && /software/install-python3.sh \
  && /software/install-ansible.sh


RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

USER jenkins
# Here you can install some Jenkins plugins if you want
