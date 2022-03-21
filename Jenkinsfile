//Send Notification Telegram
def notifyFailed-Git() {
  withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash failed-git.sh'
			}
		
}	
def notifyStarted() {
  withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash telegram-started.sh'
			}
		}
		
def notifyFailed-Install() {
  withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash failed-install.sh'
			}
		
}		
		
def notifyConnected() {
  withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash telegram-connected.sh'
			}
		
}

def notifyFailed-Connected() {
	withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash failed-connected.sh'
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

def notifyFailed-Docker() {
	withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash failed-docker.sh'
			}
		}
		
def notifyPull() {
	withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash telegram-pull.sh'
			}
		}		

def notifyFailed-Pull() {
	withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash failed-pull.sh'
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
		notifyFailed-Git()
		throw e
  }
   }

   stage('Installing dependencies') {
     nodejs(nodeJSInstallationName: 'nodejs') {	 
	   try { 
			sh 'npm install'
  }  catch (e) {
		currentBuild.result = "FAILED"
		notifyFailed-Install()
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
		notifyFailed-Connected()
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
		notifyFailed-Compile()
		throw e
  }
   }
   
   stage('Docker Build & Push') {
     
		try { 
			docker.withRegistry('https://index.docker.io/v2/', 'dockerhub') {
			def app = docker.build("mraagil/docker-nodejs", '.').push()
			notifyDocker()
			}
  }  catch (e) {
		currentBuild.result = "FAILED"
		notifyFailed-Docker()
		throw e
  }
     
   }
   
   stage('Docker Pull & Deploy Scale Out') {
		try { 
			def app = docker.build("mraagil/docker-nodejs", '.').pull()
			sh 'sudo bash deploy.sh'
			notifyPull()
  }  catch (e) {
		currentBuild.result = "FAILED"
		notifyFailed-Pull()
		throw e
  }
		
   }
   stage('Push Notification') {
		notifySuccessful()
		}

	


}
