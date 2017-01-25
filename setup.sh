#!/bin/bash

CURRENT_DIR=`dirname $0`

echo '----------------'
echo 'create docker.repo'
echo '----------------'
REPO_FILE='/etc/yum.repos.d/docker.repo'
if [ -e ${REPO_FILE} ]; then
    echo 'already exists.'
else
    sudo cp ${CURRENT_DIR}/docker.repo ${REPO_FILE}
fi

echo '----------------'
echo 'install docker engine'
echo '----------------'
sudo yum install -y docker-engine

echo '----------------'
echo 'boot docker'
echo '----------------'
sudo systemctl status docker | grep running >/dev/null 2>&1
if [ $? = 1 ]; then
    sudo systemctl start docker
else
    echo 'already started.'
fi

echo '----------------'
echo 'enable docker'
echo '----------------'
sudo systemctl status docker | grep enable >/dev/null 2>&1
if [ $? = 1 ]; then
    sudo systemctl enable docker
else
    echo 'already enabled.'
fi

echo '----------------'
echo 'install docker-compose'
echo '----------------'
if [ -e /usr/bin/docker-compose ]; then
    echo 'already exists.'
else
    curl -L "https://github.com/docker/compose/releases/download/1.8.1/docker-compose-$(uname -s)-$(uname -m)" > /tmp/docker-compose
    sudo mv /tmp/docker-compose /usr/bin/
    sudo chmod +x /usr/bin/docker-compose
    docker-compose --version
fi
