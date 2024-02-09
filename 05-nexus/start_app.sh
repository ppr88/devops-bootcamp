#!/bin/bash

# add Nexus username and password here
USER=
PASS=

# save the artifact details in a json file
curl -u $USER:$PASS -X GET 'http://167.172.178.40:8081/service/rest/v1/components?repository=my-npm-repo&sort-version' | jq "." > artifact.json

# grab the download url from the saved artifact details using 'jq' json processor tool
artifactDownloadUrl=$(jq '.items[].assets[].downloadUrl' artifact.json --raw-output)

# fetch the artifact with the extracted download url using 'wget' tool and extract it
wget -O artifact.tgz --http-user=$USER --http-password=$PASS $artifactDownloadUrl
tar -xvzf artifact.tgz

# install dependencies and execute the app
cd package
npm install
npm run start

