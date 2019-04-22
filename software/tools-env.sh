#!/bin/bash
#各种语言的PATH环境变量
export  GO_HOME=/devops/tools/go
export  SCALA_HOME=/devops/tools/scala
#export  ANSIBLE_HOME=/devops/tools/ansible

export  GRADLE_HOME=/devops/tools/gradle
export  M2_HOME=/devops/tools/maven
export  BUILDER_HOME=/devops/tools/builder
export  DEVOPS_WORKSPACE=/devops/workspace
#PATH搜索顺序是从前到后。比较好的习惯是将 导出PATH时将新增的路径放在前面,如果你的builder脚本比较新，可以直接放在/devops/workspace/scripts/目录下，替换之前镜像里的旧内容.
export  PATH=/devops/workspace/builder/scripts:/devops/workspace/scripts:$BUILDER_HOME/scripts:$PATH:$SCALA_HOME/bin:$GO_HOME/bin:$GRADLE_HOME/bin:$M2_HOME/bin:$PATH

## 安装python3 ansible software 如果是目录后面需要添加/
#虚拟环境及其激活和正确的使用方式:
export ANSIBLE_VERSION=2.7.9
export PYTHON_VERSION=3.6.6
