pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo "📦 Cloning the repository..."
                git branch: 'main', url: 'https://github.com/ananya-77/mywebapp.git'
            }
        }

        stage('Build') {
            steps {
                echo "🔧 Building the Docker image..."
                sh 'docker build -t mywebapp:latest .'
            }
        }

        stage('Test') {
            steps {
                echo "🧪 Running simple container test..."
                sh '''
                docker run --rm mywebapp:latest sh -c "echo Container test successful!"
                '''
            }
        }

        stage('Blue-Green Deploy') {
            steps {
                script {
                    echo "🚀 Starting Blue-Green deployment..."

                    // Stop and remove any existing containers
                    bat '''
                    docker stop mywebapp_blue || echo No blue container running
                    docker rm mywebapp_blue || echo No blue container to remove
                    docker stop mywebapp_green || echo No green container running
                    docker rm mywebapp_green || echo No green container to remove
                    '''

                    // Run Blue on port 9090
                    sh 'docker run -d -p 9090:80 --name mywebapp_blue mywebapp:latest'

                    // Run Green on port 9091
                    sh 'docker run -d -p 9091:80 --name mywebapp_green mywebapp:latest'

                    echo "✅ Blue (9090) and Green (9091) containers are now running!"
                }
            }
        }
    }

    post {
        success {
            echo "🎉 Pipeline executed successfully!"
        }
        failure {
            echo "❌ Pipeline failed. Check logs for details."
        }
    }
}
