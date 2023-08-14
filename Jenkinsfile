pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from GitHub repository
                checkout([$class: 'GitSCM',
                        branches: [[name: '*/master']],
                        userRemoteConfigs: [[url: 'https://github.com/kaffadu/skillsedgelab.git']]])
            }
        }

        stage('Deploy Dev') {
            steps {
                script {
                    dir('DEV') {
                        // Deploy to the Dev environment using Terraform
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve -var-file=dev.tfvars'
                    }
                }
            }
        }

        stage('Test') {
            steps {
                // Run tests on the deployed code
                sh 'mvn test' // Example test step using Maven
            }
        }

        stage('Deploy Test') {
            steps {
                script {
                    dir('TESTING') {
                        // Deploy to the Test environment using Terraform
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve -var-file=testing.tfvars'
                    }
                }
            }
        }

        stage('Deploy Stage') {
            steps {
                script {
                    dir('STAGING') {
                        // Deploy to the Stage environment using Terraform
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve -var-file=staging.tfvars'
                    }
                }
            }
        }

        stage('Deploy Prod') {
            steps {
                script {
                    dir('PROD') {
                        // Deploy to the Production environment using Terraform
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve -var-file=prod.tfvars'
                    }
                }
            }
        }

        stage('Destroy') {
            steps {
                script {
                    dir('DEV') {
                        // Destroy resources after deployment in each environment
                        sh 'terraform init'
                        sh 'terraform destroy -auto-approve -var-file=dev.tfvars'
                    }
                    dir('TESTING') {
                        sh 'terraform init'
                        sh 'terraform destroy -auto-approve -var-file=testing.tfvars'
                    }
                    dir('STAGING') {
                        sh 'terraform init'
                        sh 'terraform destroy -auto-approve -var-file=staging.tfvars'
                    }
                    dir('PROD') {
                        sh 'terraform init'
                        sh 'terraform destroy -auto-approve -var-file=prod.tfvars'
                    }
                }
            }
        }
    }
}
