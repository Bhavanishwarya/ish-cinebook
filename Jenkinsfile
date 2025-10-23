pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout from GitHub
                git branch: 'main', url: 'https://github.com/Bhavanishwarya/ish-cinebook.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build Docker image using Windows batch
                bat 'docker build -t ish-cinebook:1.0 .'
            }
        }

        stage('Push Docker Image') {
            steps {
                // Push Docker image to Docker Hub
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub-credentials', 
                    usernameVariable: 'DOCKER_USER', 
                    passwordVariable: 'DOCKER_PASS')]) {
                    
                    bat 'docker login -u %DOCKER_USER% -p %DOCKER_PASS%'
                    bat 'docker tag ish-cinebook:1.0 bhavanishwarya/ish-cinebook:1.0'
                    bat 'docker push bhavanishwarya/ish-cinebook:1.0'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                // Apply deployment and service YAMLs
                bat 'kubectl apply -f ish-cinebook-deployment.yaml'
                bat 'kubectl apply -f ish-cinebook-service.yaml'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed! Check logs for errors.'
        }
    }
}
