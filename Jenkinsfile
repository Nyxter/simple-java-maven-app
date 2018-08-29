pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'mvn -B -DskipTests clean package'
      }
    }
    stage('Out1') {
      parallel {
        stage('Out1') {
          steps {
            echo '111'
          }
        }
        stage('Out2') {
          steps {
            echo '222'
          }
        }
        stage('Fail') {
          steps {
            error 'uh oh'
          }
        }
      }
    }
  }
  environment {
    environment = 'dev'
  }
}