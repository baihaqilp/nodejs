node {
   def commit_id
   stage('Checkout Git') {
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

   stage('Compile Changes') {  
       sh 'sudo cp -v -r -f * /nodejs1'	 
   }
   
   stage('Docker Build & Push') {
     docker.withRegistry('https://index.docker.io/v2/', 'dockerhub') {
		def app = docker.build("mraagil/docker-nodejs", '.').push()
     }
   }
   
   stage('Docker Pull & Deploy Scale Out') {
     docker.withRegistry('https://index.docker.io/v2/', 'dockerhub') {
		def app = docker.build("mraagil/docker-nodejs", '.').pull()
		sh 'docker stop node-svr2 && docker rm node-svr2'
		sh 'docker stop node-svr3 && docker rm node-svr3'
		sh 'docker stop node-svr4 && docker rm node-svr4'
		sh 'docker run -p 5002:5001 -d --restart unless-stopped --name node-svr2 -v nodejs1-data:/usr/src/app -v /var/run/docker.sock:/var/run/docker.sock  mraagil/docker-nodejs'
		sh 'docker run -p 5003:5001 -d --restart unless-stopped --name node-svr3 -v nodejs1-data:/usr/src/app -v /var/run/docker.sock:/var/run/docker.sock  mraagil/docker-nodejs'
		sh 'docker run -p 5004:5001 -d --restart unless-stopped --name node-svr4 -v nodejs1-data:/usr/src/app -v /var/run/docker.sock:/var/run/docker.sock  mraagil/docker-nodejs'
		}
   }
   
}