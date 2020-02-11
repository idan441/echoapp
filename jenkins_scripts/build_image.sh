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
    #To count the number of build I store the number in the file jenkins_build_number
    last_jenkins_build_number=$(cat jenkins_build_number) #Get the numeber of the last build done by Jenkins. 
    last_jenkins_build_number=$(($last_jenkins_build_number+1)) #Increment by one number. 
    echo $last_jenkins_build_number > jenkins_build_number #Update the number for the next Jenkins build. 

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

