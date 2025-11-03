pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning the repository...'
                git 'https://github.com/ananya-77/mywebapp.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                bat 'docker build -t mywebapp:latest -f Dockerfile.dockerfile .'
            }
        }

        stage('Run Container') {
            steps {
                echo 'Running Docker container...'
                bat 'docker run -d -p 8081:80 --name mywebapp-container mywebapp:latest'
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully with Docker deployment!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
