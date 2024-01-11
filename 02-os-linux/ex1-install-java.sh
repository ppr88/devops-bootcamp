#!/bin/bash

apt-get update -y > /dev/null
apt-get install -y default-jdk > /dev/null


# 2>&1 sends both outputs of the java -version command to the same place because for some reason it outputs to STDERR
# then look for the line with the java version with 'awk'
# then extract the quotes with 'sed'
# and finally parse the version separating the string with . as separator using 'awk' again
java_version=$(java -version 2>&1 | awk '/^openjdk/{print $3}' | sed 's/"//g' | awk -F "." '{print $1}')

#printf "\n%s\n" $java_version

if [ "$java_version" == "" ]
then
    echo Installing Java has failed. No java version found	
elif [ "$java_version" -lt "1" ]
then
    echo An old version of Java installation found
elif [ "$java_version" -ge 11 ]
then
    echo Java version 11 or greater installed successfully
fi

