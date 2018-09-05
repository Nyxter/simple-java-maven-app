pipeline {
  agent any
  tools {
    maven 'Mvn3'
    jdk 'jdk8'
  }

  options {
    office365ConnectorWebhooks([[macros: [[template: '${DEPLOY}', value: 'prod']], name: 'NotifyJob', notifyBackToNormal: true, notifyFailure: true, notifySuccess: true, notifyUnstable: true, url: 'www.test.com']])
  }

  parameters {
    gitParameter branch: '', branchFilter: '.*', defaultValue: '', description: 'The branch or tag to build', name: 'BUILD_TAG', quickFilterEnabled: true, selectedValue: 'NONE', sortMode: 'NONE', tagFilter: '*', type: 'PT_BRANCH_TAG'
    choice(
            choices: 'na\nrelease',
            description: '',
            name: 'BRANCH')
    choice(
            choices: 'no\ndev\ntest\nprod',
            description: '',
            name: 'DEPLOY')
  }
  stages {
    stage('Initialize') {
      steps {
        sh '''      echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                    echo "TODO: install non maven libs - without shell script??"
                '''
      }
    }
    stage ('Build') {
      steps {
        sh 'mvn install findbugs:findbugs'
      }
      post {
        success {
          junit 'target/surefire-reports/**/*.xml'
        }
      }
    }
//    stage('Compile Findbugs Report') {
//      steps {
//        step([$class: 'FindBugsPublisher',pattern: "*/findbugs.xml",  unstableTotalAll: '0'])
//      }
//    }


    stage('Not release') {
      steps {
        echo 'not' +
                ' release'
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
        expression{ params.BUILD_TAG }
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