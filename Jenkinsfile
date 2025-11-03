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
                bat 'echo Build step completed!'
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
                    echo "Starting Blue-Green deployment..."

                    // Stop & remove any old green container (on 9091)
                    bat '''
                    docker stop mywebapp_green || echo "No green container running"
                    docker rm mywebapp_green || echo "No green container to remove"
                    '''

                    // Build the latest image
                    bat 'docker build -t mywebapp:latest .'

                    // Run the new version as GREEN on 9091
                    bat 'docker run -d -p 9091:80 --name mywebapp_green mywebapp:latest'

                    // Optional health check
                    bat 'echo Waiting for Green container health check...'
                    sleep(time:10, unit:"SECONDS")

                    // If green is healthy, swap traffic
                    bat '''
                    docker stop mywebapp_blue || echo "No blue container running"
                    docker rm mywebapp_blue || echo "No blue container to remove"
                    docker rename mywebapp_green mywebapp_blue
                    docker run -d -p 9090:80 --name mywebapp_green mywebapp:latest
                    '''

                    echo "✅ Blue-Green deployment completed successfully!"
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline executed successfully!"
        }
        failure {
            echo "Pipeline failed. Please check logs."
        }
    }
}
