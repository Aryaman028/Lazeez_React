pipeline {
  agent any

  environment {
    DOCKER_IMAGE = 'aryaman28/lazeez_react'    
    DOCKER_CREDENTIALS_ID = 'dockerhub-creds'          
  }

  stages {
    stage('Checkout') {
      steps {
        echo '📦 Cloning source code...'
        git 'https://github.com/Aryaman028/Lazeez_react' 
      }
    }

    stage('Install & Build') {
      steps {
        echo '🔧 Installing dependencies...'
        sh 'npm install'
        echo '🏗️ Building the app...'
        sh 'npm run build'
      }
    }

    stage('Docker Build') {
      steps {
        echo '🐳 Building Docker image...'
        script {
          docker.build("${DOCKER_IMAGE}")
        }
      }
    }

    stage('Docker Push') {
      steps {
        echo '📤 Pushing Docker image to Docker Hub...'
        withCredentials([usernamePassword(
          credentialsId: "${DOCKER_CREDENTIALS_ID}",
          usernameVariable: 'DOCKER_USER',
          passwordVariable: 'DOCKER_PASS'
        )]) {
          sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
          sh "docker push ${DOCKER_IMAGE}"
        }
      }
    }

    stage('Cleanup') {
      steps {
        sh 'docker logout'
        echo '🧹 Cleaned up Docker session.'
      }
    }
  }

  post {
    success {
      echo '✅ CI/CD pipeline completed successfully!'
    }
    failure {
      echo '❌ Something went wrong in the pipeline.'
    }
  }
}
