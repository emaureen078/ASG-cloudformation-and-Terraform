# ASG-cloudformation-and-Terraform# ASG with ALB Infrastructure Setup

This project demonstrates how to create an Auto Scaling Group (ASG) with an Application Load Balancer (ALB) using Infrastructure as Code (IaC) with both **Terraform** and **CloudFormation**. Each configuration deploys a simple web application that displays "Hello, World!" and scales based on load requirements.

## Project Structure


## Prerequisites

- **AWS Account** with necessary permissions to create resources like VPCs, subnets, ASGs, and ALBs.
- **AWS CLI** configured for your account.
- **Terraform CLI** installed.

## Usage

### Terraform

1. **Navigate** to the Terraform directory:

   cd project/terraform

# ASG with ALB Infrastructure Setup

This project demonstrates how to create an Auto Scaling Group (ASG) with an Application Load Balancer (ALB) using Infrastructure as Code (IaC) with both **Terraform** and **CloudFormation**. Each configuration deploys a simple web application that displays "Hello, World!" and scales based on load requirements.

## Project Structure

project/ ├── terraform/ │ ├── main.tf # Terraform configuration │ ├── variables.tf # Terraform variables ├── cloudformation/ │ ├── asg-alb.yaml # CloudFormation template



## Prerequisites

- **AWS Account** with necessary permissions to create resources like VPCs, subnets, ASGs, and ALBs.
- **AWS CLI** configured for your account.
- **Terraform CLI** installed.

