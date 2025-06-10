pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t sourav7/crud-app:latest .'
            }
        }
        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push sourav7/crud-app:latest'
                }
            }
        }
        // stage('Deploy') {
        //     steps {
        //         // Use SSH or AWS CLI to update the EC2 instance
        //     }
        // }
    }
}