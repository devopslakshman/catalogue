pipeline {
    agent any
    environment {
        IMAGE_NAME = 'catalogue'
    }
    stages {
        stage('Read Version') {
            steps {
                script {
                    def packageJson = readJSON file: 'package.json'
                    env.APP_VERSION = packageJson.version
                    echo "Building version ${env.APP_VERSION}"
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    sh """
                        npm install
                    """
                }
            }
        }

        stage('Unit Tests') {
            steps {
                script {
                    sh """
                        CATALOGUE_SERVER_PORT=9090 npm test
                    """
                }
            }
        }

        stage('Docker Image Build') {
            steps {
                script {
                    sh """
                        docker build -t ${IMAGE_NAME}:${APP_VERSION} .
                    """
                }
            }
        }
    }
}