#!/bin/bash

#jenkins-cli 使用实例  http://jenkins.devops.marathon.mesos:8080/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s http://jenkins.devops.marathon.mesos:8080  \
-auth jenkins:1199870520fb9e7a4410e15ca6cebd3863  \
build pipeline-hello-world -p id=myID -s -v