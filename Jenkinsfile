pipeline {
    // 스테이지 별로 다른 거
    agent any

    triggers {
        pollSCM('*/3 * * * *')
    }

    environment {
      AWS_ACCESS_KEY_ID = credentials('awsAccessKeyId')
      AWS_SECRET_ACCESS_KEY = credentials('awsSecretAccessKey')
      AWS_DEFAULT_REGION = 'ap-northeast-2'
      HOME = '.' // Avoid npm root owned
    }

    stages {
        // 레포지토리를 다운로드 받음
        stage('Prepare') {
            agent any
            
            steps {
                echo 'Clonning Repository'

                git url: 'https://github.com/DoyoungJ/dddd.git',
                    branch: 'master',
                    credentialsId: 'gittest'
            }

            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    echo 'Successfully Cloned Repository'
                }

                always {
                  echo "i tried..."
                }

                cleanup {
                  echo "after all other post condition"
                }
            }
        }
      
        
        stage('Lint Backend') {
            // Docker plugin and Docker Pipeline 두개를 깔아야 사용가능!
            agent {
              docker {
                image 'nginx:latest'
              }
            } 
      
        }
        
        stage('Test Backend') {
          agent {
            docker {
              image 'nginx:latest'
            }
          }
          steps {
            echo 'Test Backend'

            dir ('./server'){
                sh '''
                npm install
                npm run test
                '''
            }
          }
        }
        
        stage('Deploy') {
          agent any

          steps {
            echo 'Build Backend'

            dir ('./server'){
                sh '''
                docker run -it --name nginx_webserver -d -p 80:80 nginx
                '''
            }
          }
        }
    }
}
