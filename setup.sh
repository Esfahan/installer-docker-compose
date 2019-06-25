#!/bin/bash
DOCKER_COMPOSE_VER=1.15.0
CURRENT_DIR=`dirname $0`

# submodule
./installer-docker/setup.sh

echo '----------------'
echo 'install docker-compose'
echo '----------------'
if [ -e /usr/bin/docker-compose ]; then
    echo 'already exists.'
else
    curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VER}/docker-compose-$(uname -s)-$(uname -m)" > /tmp/docker-compose
    sudo mv /tmp/docker-compose /usr/bin/
    sudo chmod +x /usr/bin/docker-compose
    docker-compose --version
fi
