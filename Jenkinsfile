pipeline {
    agent any
    tools {
        terraform 'Terraform'
    }
    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from GitHub repository
                checkout([$class: 'GitSCM',
                        branches: [[name: '*/master']],
                        userRemoteConfigs: [[url: 'https://github.com/kaffadu/skillsedgelab.git']]])
            }
        }

        stage('Deploy Prod') {
            steps {
                script {
                    dir('PROD') {
                        // Deploy to the Prod environment using Terraform
                        sh 'terraform init'
                        echo "Terraform action is --> ${action}"
                        sh ("terraform ${action} --auto-approve -var-file=prod.tfvars")
                    }
                }
            }
        }

        stage('Deploy Dev') {
            steps {
                script {
                    dir('DEV') {
                        // Deploy to the Dev environment using Terraform
                        sh 'terraform init'
                        echo "Terraform action is --> ${action}"
                        sh ("terraform ${action} --auto-approve -var-file=dev.tfvars")
                    }
                }
            }
        }
    }
}