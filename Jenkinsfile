pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                bat 'docker build -t sourav7/crud-app:latest .'
            }
        }
        stage('Pubat') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    bat 'docker pubat sourav7/crud-app:latest'
                }
            }
        }
        // stage('Deploy') {
        //     steps {
        //         // Use Sbat or AWS CLI to update the EC2 instance
        //     }
        // }
    }
}