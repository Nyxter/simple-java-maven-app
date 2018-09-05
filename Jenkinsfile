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

        stage('Dev Deploy') {
            steps {
                echo "dev"
            }

            when {
                expression { params.DEPLOY == 'dev' }
            }
        }

        stage('Test Deploy') {
            steps {
                echo "test"
            }

            when {
                expression { params.DEPLOY == 'test' }
            }
        }

        stage('Prod Deploy') {
            steps {
                echo "prod"
            }

            when {
                expression { params.DEPLOY == 'prod' }
            }
        }

        stage ('sequentialParallel'){
            stages {
                stage('In Sequential 1') {
                    steps {
                        echo "In Sequential 1"
                    }
                }
                stage('Parallel Stage 2') {
                    parallel {
                        stage('Branch A') {
                            steps {
                                echo "On Branch A"
                            }
                        }
                        stage('Branch B') {
                            steps {
                                echo "On Branch B"
                            }
                        }
                        stage('Branch c') {
                            steps {
                                echo "On Branch d"
                            }
                        }
                        stage('Branch d') {
                            steps {
                                echo "On Branch c"
                            }
                        }
                    }
                }
                stage('In Sequential 3') {
                    steps {
                        echo "In Sequential 1"
                    }
                }
            }
        }
    }
}