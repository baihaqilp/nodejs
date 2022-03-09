node {
   def commit_id
   stage('Cloning Git') {
     checkout scm
     sh "git rev-parse --short HEAD > .git/commit-id"                        
     commit_id = readFile('.git/commit-id').trim()
   }

   stage('Installing dependencies') {
     nodejs(nodeJSInstallationName: 'nodejs') {
       sh 'npm install'	 
     }	 
   }

   stage('Testing') {
     nodejs(nodeJSInstallationName: 'nodejs') {
       sh 'npm test'	 
     }
   }

   stage('Deploy Changes') {
     nodejs(nodeJSInstallationName: 'nodejs') {
       sh 'sudo rsync -av * /nodejs1'	 
     }
   }
   
   stage('Docker Build & Push') {
     docker.withRegistry('https://index.docker.io/v2/', 'dockerhub') {
		def app = docker.build("mraagil/docker-nodejs:${commit_id}", '.').push()
     }
   }
   
}