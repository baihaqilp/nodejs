//Send Notification Telegram

def notifyFailedGit() {
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
		
def notifyInstall() {
	withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash telegram-install.sh'
			}
		
}				
		
def notifyFailedInstall() {
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

def notifyFailedConnected() {
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

def notifyFailedCompile() {
	withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash failed-compile.sh'
			}
		}		
		
def notifyDocker() {
	withCredentials([string(credentialsId: 'telegramToken', variable: 'TOKEN'),
		string(credentialsId: 'telegramChatId', variable: 'CHAT_ID')]) {
		sh 'bash telegram-docker.sh'
			}
		}		

def notifyFailedDocker() {
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

def notifyFailedPull() {
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
		notifyFailedGit()
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
		notifyFailedInstall()
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
		notifyFailedConnected()
		throw e
  }
     	 
     }
   }

   stage('Compile Changes') {  
	   try { 
			sh 'sudo rsync -av * root@192.168.200.16:/nodejs1'
			notifyCompile()
  }  catch (e) {
		currentBuild.result = "FAILED"
		notifyFailedCompile()
		throw e
  }
   }
  
   stage('Docker Build & Push') {
     
		try { 
			docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
			def app = docker.build("mraagil/docker-nodejs:mp06", '.').push()
			notifyDocker()
			}
  }  catch (e) {
		currentBuild.result = "FAILED"
		notifyFailedDocker()
		throw e
  }
     
   }
   
   stage('Docker Pull & Deploy Scale Out') {
		try { 
			sh 'docker pull mraagil/docker-nodejs:mp06'
			sh 'ssh root@192.168.200.16 sudo bash /home/deploy.sh'
			notifyPull()
			notifySuccessful()
  }  catch (e) {
		currentBuild.result = "FAILED"
		notifyFailedPull()
		throw e
  }
		
   }
   
}
	


