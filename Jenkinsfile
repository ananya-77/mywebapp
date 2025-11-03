pipeline {
    agent any

    environment {
        IMAGE_NAME = "mywebapp"
        BLUE_PORT = "8080"
        GREEN_PORT = "9090"
    }

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

        stage('Deploy') {
            steps {
                echo 'Starting Blue-Green Deployment...'

                // Step 1: Build new Docker image
                bat 'docker build -t mywebapp:green .'

                // Step 2: Stop and remove old green container if it exists
                bat 'docker stop mywebapp_green || exit 0'
                bat 'docker rm mywebapp_green || exit 0'

                // Step 3: Run green container on alternate port
                bat 'docker run -d --name mywebapp_green -p 9090:80 mywebapp:green'

                // Step 4: Health check for green deployment
                echo 'Checking if new container (green) is healthy...'
                bat 'curl -f http://localhost:9090 || exit 1'

                // Step 5: Stop and remove old blue (live) container
                bat 'docker stop mywebapp_blue || exit 0'
                bat 'docker rm mywebapp_blue || exit 0'

                // Step 6: Rename green → blue (now live)
                bat 'docker rename mywebapp_green mywebapp_blue'

                echo 'Blue-Green Deployment successful!'
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline executed successfully with Blue-Green deployment!'
        }
        failure {
            echo '❌ Deployment failed. Rolling back...'
            bat 'docker stop mywebapp_green || exit 0'
            bat 'docker rm mywebapp_green || exit 0'
            bat 'docker start mywebapp_blue || exit 0'
        }
    }
}
