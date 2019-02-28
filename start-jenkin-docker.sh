#!/bin/bash

#!/bin/bash
docker stop jenkins2
docker rm   jenkins2

firewall-cmd --add-port=8080/tcp --permanent --zone=public
firewall-cmd --reload

echo "support run docker in docker container"

docker run  -d  \
--name  jenkins2 \
--restart always \
-p 8080:8080 -p 50000:50000 \
-v /etc/localtime:/etc/localtime \
-v `pwd`/jenkins_home:/var/jenkins_home \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $(which docker):$(which docker) \
 jenkins/jenkins:20190226
