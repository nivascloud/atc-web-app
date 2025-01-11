# ATC Web Application with Monitoring

## Overview

This repository contains a **Static Web Application** integrated with **Monitoring and Visualization Tools** using Prometheus and Grafana. The infrastructure is deployed on AWS using **Terraform** and managed through Kubernetes.

---

## Current Running Application

### Endpoints

- **Static Web App:**  
  [http://a3e7ebb33ec7c4568ae95d0f5056c4f0-1473791098.us-east-1.elb.amazonaws.com:8080](http://a3e7ebb33ec7c4568ae95d0f5056c4f0-1473791098.us-east-1.elb.amazonaws.com:8080)

- **Grafana:**  
  [http://a847de951c3e54ff1a63b1dc6bb6fc64-782959289.us-east-1.elb.amazonaws.com:80](http://a847de951c3e54ff1a63b1dc6bb6fc64-782959289.us-east-1.elb.amazonaws.com:80)  
  - **Dashboard:**  
    [View Dashboard](http://a847de951c3e54ff1a63b1dc6bb6fc64-782959289.us-east-1.elb.amazonaws.com/d/fe9nhrubity4gb/new-dashboard?orgId=1&from=2025-01-11T02:10:37.875Z&to=2025-01-11T14:10:37.875Z&timezone=browser&viewPanel=panel-1)

- **Prometheus:**  
  [http://ab037d8fc9b414ed682a5b694a3631e0-936673504.us-east-1.elb.amazonaws.com:9090](http://ab037d8fc9b414ed682a5b694a3631e0-936673504.us-east-1.elb.amazonaws.com:9090)

---

## Prerequisites

Before deploying this application, ensure you have the following:

1. **Tools Installed**  
   - **Kubectl:**  
     - **Windows:**  
       ```bash
       winget install Kubernetes.kubectl
       ```
     - **Linux:**  
       ```bash
       curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
       chmod +x kubectl
       sudo mv kubectl /usr/local/bin/
       kubectl version --client
       ```
   - **Docker:**  
     - [Install Docker](https://docs.docker.com/get-docker/)
   - **Terraform:**  
     - [Install Terraform](https://developer.hashicorp.com/terraform/downloads)

2. **AWS IAM User Configuration**
   - **Sign-in URL:** [AWS Console](https://257394494879.signin.aws.amazon.com/console)  
   - **IAM User Name:** `ATC`  
   - **Password:** `password@123`
   - **Access Keys:**  
     - Access Key: `AKIATX3PIJWPRINCQJHU`  
     - Secret Key: `7Dsy************************8`
   - **IAM Policy:** Create a custom policy named `atc-web-app`:
     ```json
     {
       "Version": "2012-10-17",
       "Statement": [
         {
           "Effect": "Allow",
           "Action": [
             "iam:*",
             "cloudwatch:*",
             "kms:*",
             "logs:*",
             "ec2:*",
             "eks:*"
           ],
           "Resource": "*"
         }
       ]
     }
     ```

---

## Deployment Steps

### 1. Clone the Repository
```bash
git clone https://github.com/nivascloud/atc-web-app.git
cd atc-web-app
```
### Repository Structure

The repository contains three main directories:

1. **app**  
   This directory contains the application code and the Dockerfile to build the application image.  

2. **kubernetes**  
   Contains Kubernetes deployment files and configuration YAML files for deploying the application, Prometheus, and Grafana.  

3. **terraform**  
   Includes Infrastructure as Code (IaC) to provision AWS resources such as EKS, VPC, CloudWatch, IAM roles, and KMS for the cluster.  

---

### Steps to Deploy infrastructure and application

#### Step 1: Deploy Infrastructure Using Terraform

1. Navigate to the Terraform directory:  
   ```bash
     cd terraform
     terraform init
     terraform plan -out=tfplan
     terraform apply -auto-approve
   ```
    Outputs: eks_cluster_endpoint = "https://9A1068ED050C5A99E14D546C0781AB84.gr7.us-east-1.eks.amazonaws.com"
   
3. Build and Push the Application Image to Docker Hub
   ```bash
      cd atc-web-app/app
      docker build -t <docker_hub_username>/atc-web-app:<tag> .
      docker push <docker_hub_username>/atc-web-app:<tag>
   ```
    Verify in the your docker hub account.
  
3. Deploy Application and Services on EKS
  ```bash
      cd atc-web-app/kubernetes
      kubectl apply -f namespace.yaml
      kubectl apply -f webapp-deployment.yaml
      kubectl apply -f prometheus-config.yaml
      kubectl apply -f prometheus-deployment.yaml
      kubectl apply -f grafana-datasource-config.yaml
      kubectl apply -f grafana-deployment.yaml
  ```
4. Verify the deployment
  ```bash
      kubectl get pods -n webapp
      kubectl get pods -n monitoring
      kubectl get svc -n webapp
      kubectl get svc -n monitoring
  ```
  ![image](https://github.com/user-attachments/assets/e6c09fcf-7268-4f5b-9eef-bce0941c33da)
  ![image](https://github.com/user-attachments/assets/07dd36f3-aa3f-42cc-a175-3b2f95f4aab1)
  ![image](https://github.com/user-attachments/assets/477b0c1a-d5f0-4ffa-a580-de1fa9229783)
  ![image](https://github.com/user-attachments/assets/51861e30-8009-41e8-a6b8-4c9b9de27d7f)
