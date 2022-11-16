node {
  def image
   stage ('checkout') {
        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/chee2e/spring-petclinic.git']]])      
        }
   
   stage ('Build') {
         def mvnHome = tool name: 'maven', type: 'maven'
         def mvnCMD = "${mvnHome}/bin/mvn "
         sh "${mvnCMD} clean package"           
        }
    
    stage('Build image') {
       app = docker.build("class-mino-01/springboot")
    }

    stage('Push image to gcr') {
        docker.withRegistry('https://gcr.io', 'gcr:2-mino-01') {
            app.push("${env.BUILD_NUMBER}")
        }
    }

    stage('Update GIT') {
            script {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') 
                {
                    withCredentials([usernamePassword(credentialsId: 'gitlogin', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        def encodedPassword = URLEncoder.encode("$GIT_PASSWORD",'UTF-8')
                        sh "git config user.email pinkc47@naver.com"
                        sh "git config user.name chee2e"
                        sh "sed -i 's+class-mino-01/springboot.*+class-mino-01/springboot:${env.BUILD_NUMBER}+g' spring-boot.yaml"
                        sh "git add ."
                        sh "git commit -m 'jenkinsbuild:${env.BUILD_NUMBER}'"
                        sh "git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/${GIT_USERNAME}/myfirstapp.git HEAD:master"
                }
                    
                  }
                
            }
    }        
}
