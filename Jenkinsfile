//Send Notification Telegram
def notifyStarted() {
  withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash telegram-started.sh'
			}
		}
		
def notifyInstall() {
  withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash telegram-install.sh'
			}
		
}		
		
def notifyConnected() {
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
  withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash telegram-successful.sh'
			}
		
}		
		
node{
   def commit_id
   stage('Checkout Git') {
	 try { 
			checkout scm
			sh "git rev-parse --short HEAD > .git/commit-id"                        
			commit_id = readFile('.git/commit-id').trim()
			notifyStarted()
  }  catch (e) {
		currentBuild.result = "FAILED"
		notifyFailed()
		throw e
  }
   }

   stage('Installing dependencies') {
     nodejs(nodeJSInstallationName: 'nodejs') {	 
	   try { 
			sh 'npm install'
			notifyInstall()
  }  catch (e) {
		currentBuild.result = "FAILED"
		notifyFailed()
		throw e
  }
     }	 
   }

   stage('Testing') {
     nodejs(nodeJSInstallationName: 'nodejs') {
	 try { 
			sh 'npm test'
			notifyConnected()
  }  catch (e) {
		currentBuild.result = "FAILED"
		notifyFailed()
		throw e
  }
     	 
     }
   }

   stage('Compile Changes') {  
	   try { 
			sh 'sudo rsync -av * /nodejs1'
			notifyCompile()
  }  catch (e) {
		currentBuild.result = "FAILED"
		notifyFailed()
		throw e
  }
   }
   
   stage('Docker Build & Push') {
     docker.withRegistry('https://index.docker.io/v2/', 'dockerhub') {
		try { 
			def app = docker.build("mraagil/docker-nodejs:latest", '.').push()
			notifyDocker()
  }  catch (e) {
		currentBuild.result = "FAILED"
		notifyFailed()
		throw e
  }
     }
   }
   
   stage('Docker Pull & Deploy Scale Out') {
		try { 
			def app = docker.build("mraagil/docker-nodejs:latest", '.').pull()
			sh 'sudo bash deploy.sh'
			notifyPull()
  }  catch (e) {
		currentBuild.result = "FAILED"
		notifyFailed()
		throw e
  }
		
   }
   stage('Push Notification') {
		notifySuccessful()
		}

	


}
