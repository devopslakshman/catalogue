pipeline {
    agent any
    stages {
        stage('Read Version') {
            steps {
                script {
                    // Load and parse the JSON file
                    def packageJson = readJson file: 'package.json'
                    def appVersion = packageJson.version
                    echo "Building version ${appVersion}"
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
    }
}