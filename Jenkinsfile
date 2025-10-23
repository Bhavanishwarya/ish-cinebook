pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/Bhavanishwarya/ish-cinebook.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ish-cinebook:1.0 .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', 
                  usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'docker login -u $DOCKER_USER -p $DOCKER_PASS'
                    sh 'docker tag ish-cinebook:1.0 bhavanishwarya/ish-cinebook:1.0'
                    sh 'docker push bhavanishwarya/ish-cinebook:1.0'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f ish-cinebook-deployment.yaml'
                sh 'kubectl apply -f ish-cinebook-service.yaml'
            }
        }
    }
}
