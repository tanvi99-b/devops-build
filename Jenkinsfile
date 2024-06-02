pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'f2bce422-e3ff-412f-a2a7-24256bca1257'
        SSH_CREDENTIALS_ID = 'remote-ssh-key'
        GIT_REPO_URL = 'git@github.com:tanvi99-b/devops-build.git'
        DOCKER_DEV_REPO = 'tanvidocker99/dev'
        DOCKER_POD_REPO = 'tanvidocker99/pod'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: env.BRANCH_NAME, credentialsId: SSH_CREDENTIALS_ID, url: GIT_REPO_URL
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_DEV_REPO}:${env.BRANCH_NAME}")
                }
            }
        }

        stage('Push Docker Image to Dev Repo') {
            when {
                branch 'dev'
            }
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        dockerImage.push("${env.BRANCH_NAME}")
                    }
                }
            }
        }

        stage('Push Docker Image to Pod Repo') {
            when {
                branch 'main'
            }
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        dockerImage.push("${env.BRANCH_NAME}")
                    }
                }
            }
        }

        stage('Deploy to Server') {
            steps {
                sshagent(credentials: [SSH_CREDENTIALS_ID]) {
                    sh 'ssh -o StrictHostKeyChecking=no user@192.168.1.12 "bash deploy.sh"'
                }
            }
        }
    }
}
