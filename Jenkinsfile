stage('Blue-Green Deploy') {
    steps {
        script {
            echo "🚀 Starting Blue-Green deployment..."

            // Stop and remove existing containers
            bat 'docker stop mywebapp_blue || echo No blue container running'
            bat 'docker rm mywebapp_blue || echo No blue container to remove'
            bat 'docker stop mywebapp_green || echo No green container running'
            bat 'docker rm mywebapp_green || echo No green container to remove'

            // Build latest image
            bat 'docker build -t mywebapp:latest .'

            // Start Blue and Green containers
            bat 'docker run -d -p 9090:80 --name mywebapp_blue mywebapp:latest'
            bat 'docker run -d -p 9091:80 --name mywebapp_green mywebapp:latest'

            echo "✅ Blue (9090) and Green (9091) containers are running!"
        }
    }
}
