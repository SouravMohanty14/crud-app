pipeline {
    agent any

    stages {
        stage('Check Docker Version') {
            steps {
                bat 'docker --version'
            }
        }

        stage('Build') {
            steps {
                bat 'docker build -t sourav7/crud-app:latest .'
            }
        }

        stage('Push') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub', url: '']) {
                    bat 'docker push sourav7/crud-app:latest'
                }
            }
        }
    }
}
