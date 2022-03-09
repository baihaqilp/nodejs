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
     nodejs(nodeJSInstallationName: 'nodejs') {
       sh 'sudo rsync -av * /nodejs1'	 
     }
   }
   
   stage('Docker Build & Push') {
     docker.withRegistry('https://index.docker.io/v2/', 'dockerhub') {
		def app = docker.build("mraagil/docker-nodejs", '.').push()
     }
   }
   
   stage('Docker Pull & Deploy Scale Out') {
     docker.withRegistry('https://index.docker.io/v2/', 'dockerhub') {
		def app = docker.build("mraagil/docker-nodejs", '.').pull()
		sh 'docker run -p 5002:5001 --name -v nodejs1:/usr/src/app -v /var/run/docker.sock:/var/run/docker.sock nodejs-svr2 mraagil/docker-nodejs'
		sh 'docker run -p 5003:5001 --name -v nodejs1:/usr/src/app -v /var/run/docker.sock:/var/run/docker.sock nodejs-svr3 mraagil/docker-nodejs'
		sh 'docker run -p 5004:5001 --name -v nodejs1:/usr/src/app -v /var/run/docker.sock:/var/run/docker.sock nodejs-svr4 mraagil/docker-nodejs'
		}
   }
   
}