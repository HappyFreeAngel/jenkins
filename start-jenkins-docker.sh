#!/bin/bash

#!/bin/bash
docker stop jenkins
docker rm   jenkins

firewall-cmd --add-port=8080/tcp --permanent --zone=public
firewall-cmd --reload

echo "support run docker in docker container"

docker run  -d  \
--name  jenkins \
--restart always \
-p 12222:22 \
-p 8080:8080 \
-p 50000:50000 \
-v `pwd`/jenkins_home:/var/jenkins_home \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $(which docker):$(which docker) \
 jenkins/jenkins:lts-alpine-1.0.4
