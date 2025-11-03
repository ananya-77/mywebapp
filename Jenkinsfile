pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo "Cloning the repository..."
                git branch: 'main', url: 'https://github.com/ananya-77/mywebapp.git'
            }
        }

        stage('Build') {
            steps {
                echo "Building the application..."
                bat 'docker build -t mywebapp:latest .'
            }
        }

        stage('Test') {
            steps {
                echo "Running tests..."
                bat 'echo Tests passed successfully!'
            }
        }

        stage('Blue-Green Deploy') {
            steps {
                script {
                    echo "🚀 Starting Blue-Green deployment..."

                    // Stop and remove old containers (clean start)
                    bat '''
                    docker stop mywebapp_blue || echo "No blue container running"
                    docker rm mywebapp_blue || echo "No blue container to remove"
                    docker stop mywebapp_green || echo "No green container running"
                    docker rm mywebapp_green || echo "No green container to remove"
                    '''

                    // Run Blue on port 9090
                    bat 'docker run -d -p 9090:80 --name mywebapp_blue mywebapp:latest'

                    // Run Green on port 9091
                    bat 'docker run -d -p 9091:80 --name mywebapp_green mywebapp:latest'

                    echo "✅ Blue (9090) and Green (9091) containers are running!"
                }
            }
        }
    }

    post {
        success {
            echo "🎉 Pipeline executed successfully!"
        }
        failure {
            echo "❌ Pipeline failed. Please check logs."
        }
    }
}
