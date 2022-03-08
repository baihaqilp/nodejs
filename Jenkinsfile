pipeline {
  agent any
    
  tools {nodejs "node"}
    
  stages {
        
    stage('Cloning Git') {
      steps {
        git 'https://github.com/github-ragil/nginx-nodejs'
      }
    }
        
    stage('Install dependencies') {
      steps {
		sh 'npm init -y'
        sh 'npm install'
      }
    }
     
    stage('Test') {
      steps {
         sh 'npm test'
      }
    }      
  }
}