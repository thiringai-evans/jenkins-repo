pipeline {
    agent any 

    tools {
        maven 'Maven'
    }

        stages {

            stage("Build jar") {
                steps {
                    script {
                        echo "Building the application..."
                        sh 'mvn package'
                    }
                }
            }
            stage("build image") {

                steps {

                    script {
                        echo "Building the docker image..."
                        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                            sh 'docker build -t thiringai/docker-test:jma-2.0 .'
                            sh "docker login -u $USER -p $PASS"
                            sh 'docker push thiringai/docker-test:jma-2.0'
                        }
                    }
                
                }

            }

            stage("deploy") {

                steps {

                    script {
                        echo "deploying the application..."
                    }

                }

            }
        }
}
