pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = '1ebcdca2-35e5-4eb2-819c-5fa5743d84a5'
        DOCKER_IMAGE = 'tanvidocker99/reactapp'
        SSH_CREDENTIALS_ID = 'server-ssh-key'
        SERVER_IP = '192.168.1.6'
        CONTAINER_NAME = 'container1'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/tanvi99-b/devops-build.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${env.BUILD_ID}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_ID}").push()
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_ID}").push('latest')
                    }
                }
            }
        }

        stage('Deploy to Server') {
            when {
                branch 'main'
            }
            steps {
                script {
                    sshagent([SSH_CREDENTIALS_ID]) {
                        sh """
                        ssh -o StrictHostKeyChecking=no tester1@${SERVER_IP} '
                            docker pull ${DOCKER_IMAGE}:latest && 
                            docker stop ${CONTAINER_NAME} || true && 
                            docker rm ${CONTAINER_NAME} || true && 
                            docker run -d --name ${CONTAINER_NAME} -p 80:3000 ${DOCKER_IMAGE}:latest'
                        """
                    }
                }
            }
        }

        stage('Deploy to Dev Server') {
            when {
                branch 'dev'
            }
            steps {
                script {
                    sshagent([SSH_CREDENTIALS_ID]) {
                        sh """
                        ssh -o StrictHostKeyChecking=no tester1@${SERVER_IP} '
                            docker pull ${DOCKER_IMAGE}:latest && 
                            docker stop ${CONTAINER_NAME}-dev || true && 
                            docker rm ${CONTAINER_NAME}-dev || true && 
                            docker run -d --name ${CONTAINER_NAME}-dev -p 3001:3000 ${DOCKER_IMAGE}:latest'
                        """
                    }
                }
            }
        }
    }
}
