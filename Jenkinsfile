pipeline {
    agent any 

    tools {
        maven 'Maven'
    }

        stages {

            stage("increment version") {
                steps {
                    script {
                        echo "Incrementing app version..."
                        sh 'mvn build-helper:parse-version versions:set -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} versions:commit'
                        def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                        def version = matcher[0][1]
                        env.IMAGE_NAME = "$version-$BUILD_NUMBER"
                    }
                }
            }

            stage("Build app") {
                steps {
                    script {
                        echo "Building the application..."
                        sh 'mvn clean package'
                    }
                }
            }
            stage("build image") {

                steps {

                    script {
                        echo "Building the docker image..."
                        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                            sh "docker build -t thiringai/docker-test:${IMAGE_NAME} ."
                            sh "docker login -u $USER -p $PASS"
                            sh "docker push thiringai/docker-test:${IMAGE_NAME}"
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
