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
        booleanParam defaultValue: false, description: '', name: 'PUBLISH_FTP'
        choice(
                choices: 'N/A\ndev\ntest\nprod',
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
        stage('Build') {
            steps {
                sh 'mvn install findbugs:findbugs'
            }
            post {
                success {
                    junit 'target/surefire-reports/**/*.xml'
                }
            }
        }

        stage('Example Code analysis Report') {
            steps {
                parallel(
                        findbugs: {
                            step([$class: 'FindBugsPublisher', pattern: "*/findbugs.xml", unstableTotalAll: '0'])
                        },
                        sonatype: { echo 'EXAMPLE SONATYPE"' }
                )
            }
        }
        stage('Example FTP') {
            when {
                expression { params.PUBLISH_FTP }
            }
            steps {
                echo 'Example ftp'
            }
        }

        stage('DEPLOY to environment') {
            steps {
                parallel(
                        dev: {
                            echo "dev"
                        },
                        test: { echo "prod" },
                        prod: { echo "prod" }
                )
            }

            when {
                not {
                    expression { params.DEPLOY == 'no' }
                }
            }
        }
    }
}