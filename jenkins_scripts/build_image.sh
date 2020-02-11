#!/bin/bash

#For debugging uses - 
#This variables are supplies by Jenkins, so no need to define them while running the script from inside a Jenkinsfile. 
# GIT_HASH="8d270839c"
# BRANCH_NAME=master


#Set up the desired image name. ( application name. ) 
appname="echo" #This will be name of the images created by this script. 

#Start by showing the git commit information. 
#echo "the commit hash is ${GIT_HASH}" 
echo "the branch name is ${BRANCH_NAME}" 
echo "the branch name is ${BRANCH_NUMBER}" 
echo "the branch name is ${BUILD_NUMBER}" 


#Choose the image tag 
imagetag=""

if [ "$BRANCH_NAME" == "master" ]; then
    echo "The build number will be 0.1.${last_jenkins_build_number}"
    imagetag="0.1.${BUILD_NUMBER}"
elif [ "$BRANCH_NAME" == "dev" ]; then
    imagetag="dev_${GITHASH}"
elif [ "$BRANCH_NAME" == "staging" ]; then
    imagetag="staging_${GITHASH}"
fi

echo "the image will be tagged as - ${imagetag}"

#Now build the image. 
#The docker command assumes you are located at the directory with the dockerfile. 
docker build -t ${appname}:${imagetag} ../.

echo "finished building the image, end of shell script. " 


#Export the image name, so I can use it later in the deploy stage. 
echo "${appname}:${imagetag}" > image_name
#In the next stages in the pipeline I will need to have the image name in order to push it to GCR. 
#I chose to transfer the image name by writing and reading it from a file. 
#At the end of the pipeline the file will be destroyed by Jenkins. The file does not contain secret data. 