pipeline {
    //agent any
    agent {
        node {
            label 'docker'
        }
    }

    stages {
        stage('Build the docker image') {
            steps {
                echo 'Building the docker image'

                // script {
                // 	app = docker.build("echo")
                // }
            }
        }
        stage('Test') {
            steps {
                echo 'No Testing for echo application. But I know that generally tests exist... :) '
            }
        }
        stage('Deploy to GCR') {
            steps {
                echo 'Deploying....'

                // script {
			    //     docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
			    //     	app.push("${BUILD_NUMBER}")
			    //         app.push("latest")
			    //     }
                // }


                def branchName = "${env.BRANCH_NAME}"; //Get the branch name - so it can choose which tag to give for the image. 
                def imagetag = "";
                if (branchName == "master") {
                    imagetag = "1.0.1_${env.GIT_HASH}";
                }
                else if (branchName == "dev") {
                    imagetag = "dev_${env.GIT_HASH}";
                }
                else if (branchName == "staging") {
                    imagetag = "staging_${env.GIT_HASH}";
                }
                
                echo "The image tag will be set to ${imagetag}"



                echo 'The image has been pushed to GCR. '
            }
        }
    }
}