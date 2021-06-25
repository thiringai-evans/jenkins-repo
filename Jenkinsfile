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

            stage("commit increment") {
                steps {
                    script {
                        withCredentials([usernamePassword(credentialsId: 'github-creds', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                            sh 'git config --global user.email "jenkins@example.com"'
                            sh 'git config --global user.name "jenkins"'
                           
                            
                            sh 'git status'
                            sh 'git branch'
                            sh 'git config --list'
                            
                            sh "git remote set-url origin https://${USER}:${PASS}@github.com/thiringai-evans/jenkins-repo.git/"
                            sh 'git add .'
                            sh 'git commit -m "version increment"'
                            sh 'git push origin HEAD:master'
                        }
                    }
                }
            }
        }
}
