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
    stage('SonarQube analysis') {
        withSonarQubeEnv('Sonartest') {
          sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.2.0.1227:sonar ' +
          '-f all/pom.xml ' +
          '-Dsonar.projectKey=com.mycompany:all:master ' +
          '-Dsonar.language=java ' +
          '-Dsonar.sources=. ' +
          '-Dsonar.tests=. ' +
          '-Dsonar.test.inclusions=**/*Test*/** ' +
          '-Dsonar.exclusions=**/*Test*/**'
        }
    }
  }
  environment {
    environment = 'dev'
  }
}