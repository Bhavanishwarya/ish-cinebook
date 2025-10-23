pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'bhavanishwarya/ish-cinebook:1.0'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/Bhavanishwarya/ish-cinebook.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t ish-cinebook:1.0 .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub-credentials', 
                    usernameVariable: 'DOCKER_USER', 
                    passwordVariable: 'DOCKER_PASS')]) {
                    
                    bat 'docker login -u %DOCKER_USER% -p %DOCKER_PASS%'
                    bat 'docker tag ish-cinebook:1.0 %DOCKER_IMAGE%'
                    bat 'docker push %DOCKER_IMAGE%'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                // Skip OpenAPI validation to avoid the login/html error
                bat 'kubectl apply -f ish-cinebook-deployment.yaml --validate=false'
                bat 'kubectl apply -f ish-cinebook-service.yaml --validate=false'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully! 🎉'
        }
        failure {
            echo 'Pipeline failed! Check logs for errors.'
        }
    }
}
