
pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'tahaahmed123/devops-cicd'
        DOCKER_TAG = 'v1'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub-credentials',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login \
                        -u "$DOCKER_USER" --password-stdin
                        docker push "$DOCKER_IMAGE:$DOCKER_TAG"
                        docker logout
                    '''
                }
            }
        }
        
        stage('Deploy to AWS EC2') {
            steps {
              sh '''
            docker pull tahaahmed123/devops-cicd:v1

            docker rm -f devops-cicd-container || true

            docker run -d \
                --name devops-cicd-container \
                -p 8082:80 \
                tahaahmed123/devops-cicd:v1

            docker ps
        '''
    }
}

    }

    post {
        success {
            echo 'CI pipeline completed successfully!'
        }
        failure {
            echo 'CI pipeline failed. Check the console output.'
        }
    }
}
