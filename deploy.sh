#!/bin/bash

CNAME='node-svr2'
if [ "$(docker ps -qa -f name=$CNAME)" ]; then
    echo ":: Found container - $CNAME"
    if [ "$(docker ps -q -f name=$CNAME)" ]; then
        echo ":: Stopping running container - $CNAME"
        docker stop $CNAME;
    fi
    echo ":: Removing stopped container - $CNAME"
    docker rm $CNAME;
	
fi
echo ":: Deploying container - $CNAME"
docker run -p 5002:5001 -d --restart unless-stopped --name $CNAME -v nodejs1-data:/usr/src/app -v /var/run/docker.sock:/var/run/docker.sock  mraagil/docker-nodejs

CNAME2='node-svr3'
if [ "$(docker ps -qa -f name=$CNAME2)" ]; then
    echo ":: Found container - $CNAME2"
    if [ "$(docker ps -q -f name=$CNAME2)" ]; then
        echo ":: Stopping running container - $CNAME2"
        docker stop $CNAME2;
    fi
    echo ":: Removing stopped container - $CNAME2"
    docker rm $CNAME2;
	
fi
echo ":: Deploying container - $CNAME2"
docker run -p 5003:5001 -d --restart unless-stopped --name $CNAME2 -v nodejs1-data:/usr/src/app -v /var/run/docker.sock:/var/run/docker.sock  mraagil/docker-nodejs

CNAME3='node-svr4'
if [ "$(docker ps -qa -f name=$CNAME3)" ]; then
    echo ":: Found container - $CNAME3"
    if [ "$(docker ps -q -f name=$CNAME3)" ]; then
        echo ":: Stopping running container - $CNAME3"
        docker stop $CNAME3;
    fi
    echo ":: Removing stopped container - $CNAME"
    docker rm $CNAME3;
	
fi
echo ":: Deploying container - $CNAME3"
docker run -p 5004:5001 -d --restart unless-stopped --name $CNAME3 -v nodejs1-data:/usr/src/app -v /var/run/docker.sock:/var/run/docker.sock  mraagil/docker-nodejs

CNAME4='node-svr5'
if [ "$(docker ps -qa -f name=$CNAME4)" ]; then
    echo ":: Found container - $CNAME4"
    if [ "$(docker ps -q -f name=$CNAME4)" ]; then
        echo ":: Stopping running container - $CNAME4"
        docker stop $CNAME4;
    fi
    echo ":: Removing stopped container - $CNAME"
    docker rm $CNAME4;
	
fi
echo ":: Deploying container - $CNAME4"
docker run -p 5005:5001 -d --restart unless-stopped --name $CNAME4 -v nodejs1-data:/usr/src/app -v /var/run/docker.sock:/var/run/docker.sock  mraagil/docker-nodejs