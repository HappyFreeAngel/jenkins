
FROM jenkins/jenkins:latest

USER root
RUN echo -e "\ndeb mirrors.ustc.edu.cn stretch/updates main\n" >> /etc/apt/sources.list \
      && cat /etc/apt/sources.list \
      && apt-get update \
      && apt-get upgrade -y \
      && apt-get install -y apt-utils sudo libltdl-dev sshpass sed vim make \
      && apt-get install -y build-essential checkinstall libreadline-gplv2-dev libncursesw5-dev libssl-dev \
         libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev \
      && rm -rf /var/lib/apt/lists/*

## 安装python3 software如果是目录后面需要添加/
ADD install-python3.sh  /software/
ADD install-ansible.sh  /software/
RUN chmod +x /software/install-python3.sh && chmod +x /software/install-ansible.sh \
  && /software/install-python3.sh \
  && /software/install-ansible.sh


RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

USER jenkins
# Here you can install some Jenkins plugins if you want
