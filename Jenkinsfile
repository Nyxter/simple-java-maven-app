pipeline {
  agent any
  tools {
    maven 'Mvn3'
    jdk 'jdk8'
  }
  parameters {
    gitParameter branch: '', branchFilter: '.*', defaultValue: '', description: 'The branch or tag to build', name: 'BUILD_TAG', quickFilterEnabled: false, selectedValue: 'NONE', sortMode: 'NONE', tagFilter: '*', type: 'PT_BRANCH_TAG'
    choice(
            // choices are a string of newline separated values
            // https://issues.jenkins-ci.org/browse/JENKINS-41180
            choices: 'na\nrelease',
            description: '',
            name: 'BRANCH')
    choice(
            // choices are a string of newline separated values
            // https://issues.jenkins-ci.org/browse/JENKINS-41180
            choices: 'no\ndev\ntest\nprod',
            description: '',
            name: 'DEPLOY')
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
        expression { params.DEPLOY == 'no' }
      }
    }
    stage('release') {
      steps {
        echo 'release'
      }
      when {
        not {
          expression { params.DEPLOY == 'no' }
        }
      }
    }

    stage('Example Sonatype') {
      steps {
        echo 'not master branch Deploying'
        echo expression{ params.PT_BRANCH_TAG }
        echo branch
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