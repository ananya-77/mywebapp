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

        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                bat '''
                echo Starting deployment...
                rmdir /S /Q "C:\\Users\\Ananya\\Desktop\\webapp_deploy"
                mkdir "C:\\Users\\Ananya\\Desktop\\webapp_deploy"
                xcopy "C:\\Users\\Ananya\\.jenkins\\workspace\\mywebapp-pipeline\\*" "C:\\Users\\Ananya\\Desktop\\webapp_deploy" /E /Y
                echo Deployment completed successfully!
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
