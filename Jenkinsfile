pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'sourav7/crud-app:latest'
        APP_PORT     = '5000'
        EC2_USER     = 'ubuntu'
        EC2_HOST = credentials('EC2_IP')
    }

    stages {
        stage('Check Docker Version') {
            steps {
                bat 'docker --version'
            }
        }

        stage('Build') {
            steps {
                bat "docker build -t %DOCKER_IMAGE% ."
            }
        }

        stage('Push') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub', url: '']) {
                    bat "docker push %DOCKER_IMAGE%"
                }
            }
        }

        // stage('Deploy') {
        //     steps {
        //         sshagent(['ec2-ssh-key']) {
        //             bat """
        //                 ssh -o StrictHostKeyChecking=no %EC2_USER%@%EC2_HOST% ^
        //                     "sudo docker pull %DOCKER_IMAGE% && ^
        //                     sudo docker rm -f crud-app || true && ^
        //                     sudo docker run -d --name crud-app -p %APP_PORT%:%APP_PORT% %DOCKER_IMAGE%"
        //             """
        //         }
        //     }
        // }
    }
}
