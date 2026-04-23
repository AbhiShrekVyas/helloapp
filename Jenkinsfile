pipeline {
  agent any
  environment {
    IMAGE = "AbhiShrekVyas/helloapp"
  }
  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/AbhiShrekVyas/helloapp.git'
      }
    }
    stage('Build with Maven') {
      steps {
        sh 'mvn clean package -DskipTests'
      }
    }
    stage('Run Tests') {
      steps {
        sh 'mvn test'
      }
    }
    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $IMAGE:$BUILD_NUMBER .'
      }
    }
    stage('Push to Docker Hub') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'dockerhub',
          usernameVariable: 'USER',
          passwordVariable: 'PASS')]) {
            sh 'docker login -u $USER -p $PASS'
            sh 'docker push $IMAGE:$BUILD_NUMBER'
        }
      }
    }
    stage('Deploy to Kubernetes') {
      steps {
        sh 'kubectl set image deployment/helloapp helloapp=$IMAGE:$BUILD_NUMBER'
      }
    }
  }
  post {
    success {
      echo 'Pipeline completed successfully! App is deployed.'
    }
    failure {
      echo 'Pipeline failed. Check the logs above.'
    }
  }
}