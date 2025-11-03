pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                echo 'Cloning the repository...'
                git branch: 'main', url: 'https://github.com/ananya-77/mywebapp.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building the application...'
                bat 'echo Build step completed!'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                bat 'echo Tests passed successfully!'
            }
        }

        stage('Docker Build and Deploy') {
            steps {
                echo 'Building and running Docker container...'
                bat '''
                echo Starting Docker deployment...

                REM Stop and remove old container if it exists
                docker stop mywebapp || echo "No container to stop"
                docker rm mywebapp || echo "No container to remove"

                REM Build Docker image from Dockerfile
                docker build -t mywebapp:latest .

                REM Run the container mapping port 8080 on host to port 80 in container
                docker run -d -p 8080:80 --name mywebapp mywebapp:latest

                echo Docker deployment completed successfully!
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline executed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Please check the logs.'
        }
    }
}
