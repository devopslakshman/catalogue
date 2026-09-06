pipeline {
    agent any
    environment {
        IMAGE_NAME     = 'catalogue'
        ECR_REPO_NAME  = 'roboshop/catalogue'
        AWS_ACCOUNT_ID = '484056256762'
        AWS_REGION     = 'us-east-1'             // update if your ECR repo is in a different region
        ECR_REGISTRY   = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
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
        stage('SonarQube Analysis') {
    steps {
        script {
            def scannerHome = tool 'sonarqube-server'
            withSonarQubeEnv('sonarqube-server') {
                sh """
                    ${scannerHome}/bin/sonar-scanner \
                      -Dsonar.projectKey=catalogue \
                      -Dsonar.projectVersion=${APP_VERSION} \
                      -Dsonar.sources=.
                """
            }
        }
    }
}
                }
            }
        }
        stage('Quality Gate') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
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
        stage('Push to ECR') {
            steps {
                script {
                    sh """
                        aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REGISTRY}
                        docker tag ${IMAGE_NAME}:${APP_VERSION} ${ECR_REGISTRY}/${ECR_REPO_NAME}:${APP_VERSION}
                        docker push ${ECR_REGISTRY}/${ECR_REPO_NAME}:${APP_VERSION}
                    """
                }
            }
        }
    }
}