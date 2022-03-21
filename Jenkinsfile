def notifyStarted() {
  // send to Telegram
  withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash telegram-started.sh'
			}
		}
		
def notifyConnected() {
  // send to Telegram
  withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash telegram-connected.sh'
			}
		
}

def notifyFailed() {
	withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash telegram-failed.sh'
			}
		}
		
def notifyCompile() {
	withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash telegram-compile.sh'
			}
		}		

def notifyDocker() {
	withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash telegram-docker.sh'
			}
		}

def notifyPull() {
	withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash telegram-pull.sh'
			}
		}
		
def notifySuccessful() {
  // send to Telegram
  withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash telegram-successful.sh'
			}
		
}		
		
node {
   def commit_id
   stage('Checkout Git') {
     notifyStarted()
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
	 try { 
	   sh 'npm test'
       notifySuccessful()
  }  catch (e) {
     currentBuild.result = "FAILED"
     notifyFailed()
     throw e
  }
	
       	 
     }
   }

   stage('Compile Changes') {  
       sh 'sudo rsync -av * /nodejs1'
	   notifyCompile()
   }
   
   stage('Docker Build & Push') {
     docker.withRegistry('https://index.docker.io/v2/', 'dockerhub') {
		def app = docker.build("mraagil/docker-nodejs", '.').push()
		notifyDocker()
     }
   }
   
   stage('Docker Pull & Deploy Scale Out') {
		def app = docker.build("mraagil/docker-nodejs", '.').pull()
		sh 'sudo bash deploy.sh'
		notifyPull()
		
   }
   stage('Push Notification') {
		notifySuccessful()
		}

	


}
