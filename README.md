# ATC Web Application with Monitoring

## Overview

This repository contains a **Static Web Application** integrated with **Monitoring and Visualization Tools** using Prometheus and Grafana. The infrastructure is deployed on AWS using **Terraform** and managed through Kubernetes.

---

## Current Running Application

- **Static Web App**  
  [Access the Application](http://a3e7ebb33ec7c4568ae95d0f5056c4f0-1473791098.us-east-1.elb.amazonaws.com:8080)

- **Grafana**  
  [Access Grafana](http://a847de951c3e54ff1a63b1dc6bb6fc64-782959289.us-east-1.elb.amazonaws.com:80)  
  - **Dashboard Example**  
    [View Dashboard](http://a847de951c3e54ff1a63b1dc6bb6fc64-782959289.us-east-1.elb.amazonaws.com/d/fe9nhrubity4gb/new-dashboard?orgId=1&from=2025-01-11T02:10:37.875Z&to=2025-01-11T14:10:37.875Z&timezone=browser&viewPanel=panel-1)

- **Prometheus**  
  [Access Prometheus](http://ab037d8fc9b414ed682a5b694a3631e0-936673504.us-east-1.elb.amazonaws.com:9090)

---

## Prerequisites

Before deploying, ensure you have the following tools and configurations:

### Tools to Install

- **Kubectl**
  - **Windows**:  
    ```bash
    winget install Kubernetes.kubectl
    ```
  - **Linux**:  
    ```bash
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
    kubectl version --client
    ```

- **Docker**
  - **Windows**: [Install Docker Desktop](https://docs.docker.com/desktop/setup/install/windows-install/)  
  - **Linux**: [Install Docker](https://docs.docker.com/engine/install/)

- **Terraform**  
  [Install Terraform](https://developer.hashicorp.com/terraform/install?product_intent=terraform)

---

### AWS IAM User Configuration

1. **Create an IAM User**
   - **Sign-in URL**: [AWS Console](https://257394494879.signin.aws.amazon.com/console)  
   - **Username**: `ATC`  
   - **Password**: `password@123`

2. **Generate Access Keys**
   - **Access Key**: `AKIATX3PIJWPRINCQJHU`  
   - **Secret Access Key**: `7DsylgfdiJwXJqw7D2uIvGUUirG/xfoBER4lNP8`

3. **Attach IAM Policy**  
   Create a custom policy named `atc-web-app`:
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
