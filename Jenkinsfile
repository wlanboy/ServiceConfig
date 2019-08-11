pipeline {
  agent any
  stages {
    stage('Git') {
      steps {
        git(url: 'https://github.com/wlanboy/ServiceConfig.git', branch: 'master')
      }
    }
    stage('Build') {
      steps {
        sh 'mvn clean package'
      }
    }
    stage('Publish') {
      steps {
        withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
          sh 'docker push wlanboy/serviceconfig:latest'
        }
      }
    }
  }
}