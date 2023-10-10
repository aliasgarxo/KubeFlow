pipeline {
    agent any
    tools {
        maven 'Maven-3.6.1'
    }
    

    stages {
        stage('git checkout') {
            steps {
                git 'https://github.com/aliasgarxo/KubeFlow'
            }
        }
        stage("Maven Build"){
            steps{
                sh "mvn clean sonar:sonar package"
                
            }
        }
        stage('Upload War To Nexus'){
            steps{
                  nexusArtifactUploader artifacts: [
                       [
                            artifactId: 'myweb', 
                            classifier: '', 
                            file: "target/myweb-8.2.0.war", 
                            type: 'war'
                       ]
                  ], 
                  credentialsId: 'nexus3', 
                  groupId: 'in.javahome', 
                  nexusUrl: '3.111.144.50:8081', 
                  nexusVersion: 'nexus3', 
                  protocol: 'http', 
                  repository: 'Arch-Proj', 
                  version: '8.2.0'  
            }
        }
        stage('Build docker image'){
            steps{
                sh """
                        docker build -t myimg .
                        docker image tag myimg:latest dullhuke/dullhuke:latest
                """
            }
        }
        stage('docker image push'){
            steps{
                withCredentials([string(credentialsId: 'CRED_DOCKER', variable: 'CRED_DOCKER')]) {
                    sh "docker login -u=dullhuke -p=${CRED_DOCKER}"
                }
                docker push dullhuke/dullhuke:latest
            }
        }
    }
}