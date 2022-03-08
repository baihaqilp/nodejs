node {
   def commit_id
   stage('Preparation') {
     checkout scm
     sh "git rev-parse --short HEAD > .git/commit-id"                        
     commit_id = readFile('.git/commit-id').trim()
   }
   stage('test') {
     nodejs(nodeJSInstallationName: 'nodejs') {
       sh 'npm install'	 
       sh 'npm test'
     }
   }
   stage('deploy') {
     nodejs(nodeJSInstallationName: 'nodejs') {
       sh 'sudo rsync -av * /var/lib/docker/volumes/nodejs-data/_data '	 
     }
   }
   
}