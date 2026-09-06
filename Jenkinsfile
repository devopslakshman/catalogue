pipeline{
    agent any
    stagees{
        stage(read version){
            steps{
                script{
                    //load and parse the Json file
                    def packageJson=readJson file:'pacjage.json'
                }
                //access fields directly
                def appVersion= readJson file:'pacjage.json'
                //access fields directly
                 appVersion = packageJson.version
                    echo "Building version ${appVersion}"
            }

        }

    }
    stage('Install Dependencies') {
            steps {
                script{
                    sh """
                        npm install
                    """
 

}
stage('Install Dependencies') {
            steps {
                script{
                    sh """
                        npm install
                    """