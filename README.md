# automated-cicd-pipeline
Automated CI/CD Pipeline with Infrastructure as Code, Microservices Integration, Service Mesh Networking, and End-to-End Monitoring

# AWS-DevOps-Project-Automated-CI-CD-Pipeline
This project walks you through building a robust CI/CD pipeline to automatically deploy a microservices application on AWS using Kubernetes (EKS). It leverages Istio for service mesh and Jenkins for CI/CD automation. You'll learn how to provision infrastructure with Terraform and manage microservices in a secure, scalable, and highly observable setup.

![DALL·E 2024-12-31 22 32 34 - A professional architectural diagram of a modern cloud-native application setup, visually designed to look like it was created by a human  The image i](https://github.com/user-attachments/assets/e066fdc5-ef2c-4e70-a1f7-353872007ff1)

## 1. Project Overview

- In this project, you’ll learn how to set up a powerful CI/CD pipeline that takes the hassle out of deploying a microservices-based application on AWS. We’ll be using Kubernetes (EKS) to manage our containers, Istio to handle communication between services, and Jenkins to automate the build and deployment process.

- We’ll start from the ground up by provisioning the necessary infrastructure using Terraform, ensuring everything is set up securely and efficiently. From there, you’ll see how to deploy and manage microservices in a way that scales effortlessly as your app grows. You’ll also learn how to monitor and observe your environment, so you always know what’s happening under the hood.

- By the end of this project, you’ll have a fully automated CI/CD pipeline that not only speeds up deployment but also keeps your application running smoothly and securely, even as it scales. Whether you’re looking to enhance your DevOps skills or streamline your deployment process, this project has you covered.


## Architecture Overview

![Actual architecture diagram!](https://github.com/akshayshelke1/automated-cicd-pipeline/blob/main/architecture/architecture.png)

1.  #### Developer Workstations: #### 
Developers write and commit code to a GitHub repository, kicking off the automation process.

- Number 2 Continuous Integration:
Jenkins automatically pulls the latest code from GitHub, builds the application, and runs tests to catch any issues early.
It then creates Docker images of the application and pushes them to a Docker Registry, like Amazon ECR, ensuring consistent and reliable deployments.

- Number 3 Infrastructure as Code:
Terraform handles the infrastructure setup on AWS, which includes:

  - VPC: For secure networking.
  - IAM Roles and Policies: Ensuring proper security and permissions.
  - EKS Cluster: To run the Kubernetes workloads.
  - RDS: For managing persistent storage needs.

- Number 4 Continuous Deployment:
Jenkins takes the Docker images from the registry and deploys them to the Amazon EKS cluster using Kubernetes manifests or Helm charts.
Istio is used as a service mesh to efficiently manage traffic between microservices, enhancing communication and security.

- Number 5 Service Mesh with Istio:
Istio plays a key role in managing traffic, securing communication with mutual TLS (mTLS), and providing observability into the microservices environment.
The Istio Ingress Gateway manages all external access to the services, ensuring secure and reliable routing.

- Number 6 Monitoring and Logging:
Prometheus collects detailed metrics from the Kubernetes cluster and Istio, providing real-time insights.
Grafana visualizes these metrics through interactive dashboards.
Fluentd centralizes logging, sending logs to Amazon CloudWatch or Elasticsearch for easy monitoring and troubleshooting.
Alertmanager integrates with Prometheus to trigger alerts when issues are detected.

- Number 7 Continuous Feedback:
Alertmanager notifies the team through Slack or email, ensuring quick response times to any incidents.
Jenkins provides continuous feedback on build and deployment statuses, keeping developers in the loop throughout the CI/CD pipeline.
This setup ensures a seamless flow from code commit to deployment, with robust monitoring, security, and feedback mechanisms, making the application scalable, secure, and highly observable.



### Pre-requisites
AWS Account.
"Terraform installed locally.
Kubectl and Helm installed.
Jenkins installed and configured.
Docker installed.
Prometheus and Grafana configured for monitoring."


2. Prerequisites
AWS Account: Administrative access to an AWS account.
AWS CLI: Installed and configured with appropriate credentials.
Terraform: Installed on your local machine.
kubectl: Installed for managing Kubernetes clusters.
Jenkins: Installed on an EC2 instance or set up via Docker.
Docker: Installed and running on your local machine.
Git: Installed and configured.
Helm: Installed for Kubernetes package management.
3. Architecture Diagram
