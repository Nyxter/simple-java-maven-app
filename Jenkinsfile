pipeline {
  agent any
  tools {
    maven 'Mvn3'
    jdk 'jdk8'
  }
  parameters {
    choice(
            // choices are a string of newline separated values
            // https://issues.jenkins-ci.org/browse/JENKINS-41180
            choices: 'release\nnah',
            description: '',
            name: 'REQUESTED_ACTION')
  }
  stages {
    stage('Initialize') {
      steps {
        sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
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
//    stage('Example findbugs') {
//      steps {
//        step([$class: 'FindBugsPublisher', pattern: "*/findbugs/main.xml", unstableTotalAll: '0'])
//      }
//    }


    stage('Not release') {
      steps {
        echo 'not release'
      }
      when {
        not {
          expression { params.REQUESTED_ACTION == 'release' }
        }
      }
    }
    stage('release') {
      steps {
        echo 'release'
      }
      when {
        expression { params.REQUESTED_ACTION == 'release' }
      }
    }

    stage('Example Sonatype') {
      steps {
        echo 'Deploying'
      }
      when {
        not {
          branch 'master'
        }
      }
    }
    stage('Example FTP') {
      when {
        branch 'master'
      }
      steps {
        echo 'Deploying'
      }
    }
  }
}