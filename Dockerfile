
FROM jenkins/jenkins:lts-alpine-1.0.0

#bugfix 覆盖原来的配置.
ADD software/settings.xml  /devops/tools/maven/conf/
#更改默认的插件下载地址
ADD software/hudson.model.UpdateCenter.xml  /var/jenkins_home/
#更新builder 工具到最新的版本
ADD software/builder.tgz   /devops/tools
#更新starter.sh为最新的版本
ADD software/starter.sh  /server/
ADD software/tools-env.sh /etc/profile.d/

USER root
ENTRYPOINT  ["/server/starter.sh", "-D", "FOREGROUND"]

#USER jenkins
# Here you can install some Jenkins plugins if you want