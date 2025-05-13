

# 🚀 AWS Auto Scaling Infrastructure with Terraform and GitHub Actions CI/CD

---

📌 Prerequisites
AWS Account with IAM permissions for EC2, ALB, Auto Scaling, VPC

Terraform installed locally

GitHub repository with correct secrets setup

AWS EC2 Key Pair already created

## 📋 Project Overview

This project builds a fully automated, highly available AWS infrastructure using Terraform, integrated with a GitHub Actions CI/CD pipeline.  

**Key Features:**
- Virtual Private Cloud (VPC) with Public Subnets
- Application Load Balancer (ALB)
- Auto Scaling Group (ASG) of EC2 Instances
- CloudWatch Alarms for CPU-based scaling
- Secure Key Pair Management via GitHub Secrets
- Full Infrastructure Deployment on Git Push

✅ No PEM file exposed  
✅ Full modular Terraform code  
✅ Automatic deployment after GitHub push

---

## 🏛️ Architecture Diagram

```plaintext
GitHub → GitHub Actions → Terraform → AWS
        ⬇️
AWS Infrastructure:
- VPC (10.0.0.0/16)
- Two Public Subnets
- Application Load Balancer (ALB)
- Target Group
- Launch Template
- Auto Scaling Group
- CloudWatch Alarms (for CPU scaling)
📂 Project Structure
plaintext
Copy
Edit
autoscaling-infra/
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── alb/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── ec2_asg/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── provider.tf
├── .gitignore
├── README.md
└── .github/
    └── workflows/
        └── terraform.yml
⚙️ How It Works
You push Terraform code to GitHub main branch.

GitHub Actions is triggered automatically.

GitHub Secrets (TF_VAR_key_name, AWS credentials) are injected.

Terraform runs init, plan, and apply.

AWS Infrastructure is provisioned automatically!

✅ Fully automated deployment.
✅ Secure key management.

📜 GitHub Secrets Setup
You must create the following Secrets inside your GitHub repository:

Secret Name	Value
AWS_ACCESS_KEY_ID	Your AWS IAM Access Key
AWS_SECRET_ACCESS_KEY	Your AWS IAM Secret Key
AWS_REGION	AWS Region (e.g., us-east-1)
TF_VAR_key_name	The Key Pair Name from AWS EC2 (e.g., autoscaling-key)

✅ Important:

Only the Key Pair Name is stored (TF_VAR_key_name).

❌ Do not upload or store PEM files in GitHub.

🧱 Terraform Modules Details
Module	Resources
vpc	VPC, Subnets
alb	Application Load Balancer, Target Group, Listener
ec2_asg	Launch Template, Auto Scaling Group, EC2 Instances

🛠️ How to Deploy Locally (Manual Terraform Commands)

# Step 1: Initialize Terraform
terraform init

# Step 2: Format Terraform Files
terraform fmt

# Step 3: Validate Terraform Code
terraform validate

# Step 4: Plan Changes
terraform plan

# Step 5: Apply Infrastructure
terraform apply -auto-approve
✅ This will create VPC, ALB, EC2s, and ASG on AWS automatically.

🚀 How the GitHub Actions CI/CD Pipeline Works
The .github/workflows/terraform.yml file defines the CI/CD pipeline.

Pipeline steps:

Checkout Code

Setup Terraform

Configure AWS Credentials

Terraform Init

Terraform Plan

Terraform Apply

✅ No need for manual apply after push.

🔥 Stress Test (Trigger Auto Scaling)
After deployment:

SSH into an EC2 instance:

chmod 400 your-keypair-name.pem
ssh -i your-keypair-name.pem ec2-user@<Public-IP>
Install and run stress tool:

sudo yum install -y stress
stress --cpu 4 --timeout 300
✅ CPU load will trigger CloudWatch alarms.
✅ Auto Scaling Group will scale OUT (add EC2 instances) if CPU > 70%.
✅ Scale IN if CPU drops below 30%.

📚 Technologies Used
Terraform v1.6.x

AWS VPC, EC2, Auto Scaling, ALB, CloudWatch

GitHub Actions

Amazon Linux 2 AMI

🛡️ Security Best Practices
Action	Reason
Only use Key Pair Name in GitHub Secrets (TF_VAR_key_name)	Never expose PEM
Store AWS credentials in GitHub Secrets	Secure handling
Never upload PEM files to GitHub	Prevent unauthorized SSH access
Use GitHub Actions to inject Secrets	Safe and encrypted





🤝 Author
Developed by Prameshwar 
