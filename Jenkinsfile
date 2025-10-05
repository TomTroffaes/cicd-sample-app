node {
    stage('Preparation') {
        catchError(buildResult: 'SUCCESS') {
            sh 'docker rm -f samplerunning 2>/dev/null || true'
            sh 'rm -rf tempdir || true'
        }
    }

    stage('Checkout') {
        checkout scm
    }

    stage('Build') {
        build 'BuildSampleApp'
    }

    stage('Results') {
        build 'TestSampleApp'
    }
}
