pipeline {
  agent any
  tools {
    maven 'Mvn3'
    jdk 'jdk8'
  }
  stages {
    stage('Initialize') {
      steps {
        sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                    echo "JAVA_HOME = "
                    echo java -version
                '''
      }
    }
    stage ('Build') {
      steps {
        sh 'mvn -Dmaven.test.failure.ignore=true install'
      }
      post {
        success {
          junit 'target/surefire-reports/**/*.xml'
        }
      }
    }
  }
}