# Create a Jenkins pipeline script to automate the build, test, and deployment process:

```groovy
pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/your-repo/microservices-app.git'
      }
    }
    stage('Build') {
      steps {
        sh 'mvn clean package'
      }
    }
    stage('Docker Build & Push') {
      steps {
        script {
          docker.build("user-service:latest").push("${env.BUILD_TAG}")
        }
      }
    }
    stage('Deploy to EKS') {
      steps {
        script {
          sh 'kubectl apply -f k8s/deployment.yaml'
          sh 'kubectl apply -f k8s/service.yaml'
        }
      }
    }
  }
}
```
