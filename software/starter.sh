#!/bin/bash
echo "starter.sh version 2019.03.26"
current_file_path=$(cd "$(dirname "$0")"; pwd)

echo "starting sshd for remote login... 支持自定义用户root密码, 可以通过SSHD_PASSWORD环境变量传入修改默认的root密码"
/run_sshd.sh &


#这个目录是根据Dockerfile里 ADD starter.sh  /server/ 推断出肯定是/server
cd ${current_file_path}
echo "downloadURL="$downloadURL

compressedFilename=$(echo $downloadURL | rev | cut -d "/" -f1 | rev)
echo "downloadFileName="$compressedFilename
gitword=".git"
targzword=".tar.gz"
tgzword=".tgz"
zipword=".zip"
tarxzword=".tar.xz"

if [[ $compressedFilename == *$gitword* ]]; then
    echo "git clone $downloadURL will start now .."
    git clone $downloadURL
fi


protocal='none'
OLD_IFS="$IFS"
IFS=":"
arr=($downloadURL)
IFS="$OLD_IFS"
for s in ${arr[@]}
do
    protocal=$s
    break
done

echo "protocal="$protocal

downloadcmd="curl -O "
#http  curl -O
#https  curl -O --insecure
#http  wget
#https  wget --no-check-certificate

#设置解压后的文件夹名称
app_foldername="docker_app"
`mkdir ${app_foldername}`

ls -al

if  [ "$protocal" == "https" ]
then
      downloadcmd="curl -O --insecure "
elif  [ "$protocal" == "http" ]
then
     downloadcmd="curl -O "

elif  [ "$protocal" == "file" ]
then
     downloadcmd="curl -O "
else
     echo "unknow protocal $protocal"
fi


if [[ $compressedFilename == *$targzword* ]]; then
      echo "targzword= download $downloadURL will start now."
      $downloadcmd  $downloadURL
      tar -zxvf ${compressedFilename} -C  ${app_foldername} --strip-components=1;
fi


if [[ $compressedFilename == *$tgzword* ]]; then
      echo "tgzword= download $downloadURL will start now."
      $downloadcmd  $downloadURL
      tar -zxvf ${compressedFilename} -C  ${app_foldername} --strip-components=1;
fi

if [[ $compressedFilename == *$tarxzword* ]]; then
      echo "tarxzword= download $downloadURL will start now."
      $downloadcmd  $downloadURL
      tar -zxvf ${compressedFilename} -C  ${app_foldername} --strip-components=1;
fi


if [[ $compressedFilename == *$zipword* ]]; then
       echo "zipword= download $downloadURL will start now."
       $downloadcmd  $downloadURL

       mkdir tmp
       unzip -d tmp $compressedFilename
       cd tmp;
       unpredictFoldername=$(ls)
       mv $unpredictFoldername  ../${app_foldername}
       cd ..
       ls -al $unpredictFoldername;
       rm -rf tmp
       #unzip -d ${compressedFilename} -j $compressedFilename 这个有问题会把所有文件夹下的文件解压缩到同一个目录下
fi

pwd && ls -al;


if [[  -f "/server/${app_foldername}/run.sh" ]];
then
    cd ${app_foldername};pwd;
    chmod +x run.sh
    ./run.sh
else
     echo "启动默认nginx进程..."
     nginx -g 'daemon off;'
#CMD ["nginx", "-g", "daemon off;"]
fi


tini -- /usr/local/bin/jenkins.sh
#ENTRYPOINT ["tini", "--", "/usr/local/bin/jenkins.sh"]
