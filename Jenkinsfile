pipeline {
    agent {
        label 'master'
    }
    
    stages {
        stage('creating ECR Repository') {
            steps {
                echo 'creating ECR Repository'
            }
        }
        stage('building Docker Image') {
            steps {
                echo 'building Docker Image'
            }
        }
        stage('pushing Docker image to ECR Repository') {
            steps {
                echo 'pushing Docker image to ECR Repository'
            }
        }
        stage('creating infrastructure for the Application') {
            steps {
                echo 'creating infrastructure for the Application'
            }
        }
        stage('deploying the Application') {
            steps {
                echo 'deploying the Application'
            }
        }
    }
    post {
        always {
            echo 'Goodbye ALL... Please come back soon'
        }
        failure {
            echo 'Sorry but you messed up...'
        }
        success {
            echo 'You are the man/woman...'
        }
    }
}