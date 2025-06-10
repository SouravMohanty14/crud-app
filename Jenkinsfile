pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                bat 'docker build -t sourav7/crud-app:latest .'
            }
        }
        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    bat 'docker push sourav7/crud-app:latest'
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