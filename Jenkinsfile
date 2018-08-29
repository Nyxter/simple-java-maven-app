pipeline {
  agent {
    docker {
      image 'maven:3-alpine'
      args '-v /root/.m2:/root/.m2'
    }

  }
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
      }
    }
    stage('test') {
      steps {
        sh 'mvn test'
      }
    }
  }
  environment {
    environment = 'dev'
  }
}