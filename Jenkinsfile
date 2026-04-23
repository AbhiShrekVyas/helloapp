pipeline {
  agent any
  environment {
    IMAGE = "YOURUSERNAME/helloapp"
    # Replace YOURUSERNAME with your Docker Hub username
  }
  stages {

    stage('Checkout') {
      steps {
        git 'https://github.com/abhivyas14/helloapp.git'
      }
    }

    stage('Build with Maven') {
      steps {
        sh 'mvn clean package -DskipTests'
        # -DskipTests: build fast, tests run in next stage
      }
    }

    stage('Run Tests') {
      steps {
        sh 'mvn test'
        # Runs unit tests. Build fails here if any test fails.
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $IMAGE:$BUILD_NUMBER .'
        # $BUILD_NUMBER auto-increments (1, 2, 3...)
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
        # Updates the running deployment to use the new image version
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
