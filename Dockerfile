
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
RUN  apt-get update \
&&  apt-get -f install -y apt \
&& apt-get -f install -y apt-utils \
&& apt-get upgrade -y \
&& apt-get update \
&&  echo "\ndeb http://mirrors.163.com/debian/ jessie main non-free contrib\n" >> /etc/apt/sources.list \
&&  echo "\ndeb http://mirrors.163.com/debian/ jessie-updates main non-free contrib"  >> /etc/apt/sources.list \
&&  echo "\ndeb http://mirrors.163.com/debian/ jessie-backports main non-free contrib"  >> /etc/apt/sources.list \
&&  echo "\ndeb-src http://mirrors.163.com/debian/ jessie main non-free contrib"  >> /etc/apt/sources.list \
&&  echo "\ndeb-src http://mirrors.163.com/debian/ jessie-updates main non-free contrib"  >> /etc/apt/sources.list \
&&  echo "\ndeb-src http://mirrors.163.com/debian/ jessie-backports main non-free contrib"  >> /etc/apt/sources.list \
&&  echo "\ndeb http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib"  >> /etc/apt/sources.list \
&&  echo "\ndeb-src http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib"  >> /etc/apt/sources.list \
      && cat /etc/apt/sources.list \
      && apt-get update \
      && apt-get upgrade -y \
      && apt-get update \
      && apt-get -f install -y apt-utils apt-transport-https \
      && apt-get -f install -y sudo libltdl-dev sshpass sed vim make \
      && apt-get -f install -y build-essential checkinstall libreadline-gplv2-dev libncursesw5-dev libssl-dev \
         libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev \
      && rm -rf /var/lib/apt/lists/*   \
      && apt-get upgrade -y

## 安装python3 ansible software如果是目录后面需要添加/
ADD install-python3.sh  /software/
ADD install-ansible.sh  /software/
RUN chmod +x /software/install-python3.sh && chmod +x /software/install-ansible.sh \
  && /software/install-python3.sh \
  && /software/install-ansible.sh


RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

USER jenkins
# Here you can install some Jenkins plugins if you want
