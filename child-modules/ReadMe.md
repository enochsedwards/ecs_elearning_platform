E-LEARNING PLATFORM PROJECT

Build code for:
DEV environment         Port 80
TEST environment        Port 80   
STAGING environment     Port 80
PROD Environment        Port 443

Push all codes to a git repo
Create a personal JIRA account
Provision a Jenkins server using a Jenkinsfile  to deploy resources to AWS

ECS INFRASTRUCTURE
Create your Dockerfile from Nginx
Create a docker image using Nginx
Push the image to ECR

NETWORK INFRASTRACTURE
VPC
1 X VPC [10.0.0.0/16]
1 X IGW
2 x AZS [us-west-1a] [us-west-1b]
2 x PUBLIC SUBNETS [us-west-1a] [10.0.10.0/24] [10.0.11.0/24] 
2 X PRIVATE SUBNETS [us-west-1B] [10.0.12.0/24] [10.0.13.0/24]
1 X NGW
1 X EIP
1 X ALB [TO BE PLACED IN THE PUBLIC SUBNETS]


