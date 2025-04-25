pipeline {
    agent any

    stages {
        stage('Docker Cleanup') {
            steps {
                bat '''
                docker stop lazeez_react || echo Container not running
                docker rm lazeez_react || echo No container to remove
                docker rmi -f lazeez_react || echo No image to remove
                '''
            }
        }
        stage('Build Docker Image') {
            steps {
                bat 'docker build -t lazeez_react .'
            }
        }
        stage('Run Container') {
            steps {
                bat 'docker run -d -p 3000:80 --name lazeez_react lazeez_react'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat '''
                        docker login -u %DOCKER_USER% -p %DOCKER_PASS%
                        docker tag lazeez_react %DOCKER_USER%/lazeez_react
                        docker push %DOCKER_USER%/lazeez_react
                    '''
                }
            }
        }        
    }
}