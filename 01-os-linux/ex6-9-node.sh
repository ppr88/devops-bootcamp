#!/bin/bash

# kill process if it is already running
pid=$(ps aux | grep "server.js" | grep -v grep | awk '{print $2}')
kill -9 $pid

# install all the tools we need
#apt update
#apt install nodejs npm curl -y

echo "Node version: $(node -v)"
echo "NPM version: $(npm -v)"

# create service user
NEWUSER=myapp
useradd $NEWUSER -m

# download and unzip the project file
URL="https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz"
FILE="ex6-file.tgz"
DIR="package"
runuser -l $NEWUSER -c "
	curl $URL -o $FILE &&
	tar zxvf $FILE
	cd $DIR &&
	npm install"

# setup config for execution
APP="$DIR/server.js"

echo "Set directory (absolute path) for the app to store its logs: "
read LOGDIR
if [ -d $LOGDIR ]
then
	echo "Directory already exists"
else
	mkdir $LOGDIR
	chown $LOGDIR -R $USER 
	echo "Directory $LOGDIR created"
fi

# execute the app
runuser -l $NEWUSER -c "pwd"
runuser -l $NEWUSER -c "
	export LOG_DIR=$LOGDIR APP_ENV=dev DB_USER=myuser DB_PWD=mysecret &&
	node $APP &"

# wait for first logs to be written and get process id and port
sleep 1
pid=$(ps aux | grep "server.js" | grep -v grep | awk '{print $2}')
port=$(netstat -ltnp | grep node | awk '{print $4}' | grep -oP '[0-9]+')

echo "App running in process $pid and listening in port $port..."







