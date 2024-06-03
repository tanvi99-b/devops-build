pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('1ebcdca2-35e5-4eb2-819c-5fa5743d84a5')
        SSH_CREDENTIALS = credentials('server-ssh-key')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("myapp:${env.BUILD_ID}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_HUB_CREDENTIALS) {
                        docker.image("myapp:${env.BUILD_ID}").push('latest')
                    }
                }
            }
        }

        stage('Deploy to Server') {
            steps {
                sshagent([SSH_CREDENTIALS]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no tester1@192.168.1.12 'docker pull myapp:latest && docker run -d -p 80:80 myapp:latest'
                    """
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
