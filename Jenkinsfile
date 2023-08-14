pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from GitHub repository
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/kaffadu/skillsedgelab.git']])
            }
        }

        stage('Deploy Dev') {
            steps {
                -chdir('DEV') {
                    // Deploy to the Dev environment using Terraform
                    sh 'terraform init dev' // Initialize Terraform in the dev directory
                    sh 'terraform apply -auto-approve dev' // Deploy using Terraform in the dev directory
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
                -chdir('TESTING') {
                    // Deploy to the Test environment using Terraform
                    sh 'terraform init test'
                    sh 'terraform apply -auto-approve test'
                }
                
            }
        }

        stage('Deploy Stage') {
            steps {
                -chdir('TESTING') {
                    // Deploy to the Stage environment using Terraform
                    sh 'terraform init stage'
                    sh 'terraform apply -auto-approve stage'
                }
            }
        }

        stage('Deploy Prod') {
            steps {
                -chdir('PROD') {
                    // Deploy to the Production environment using Terraform
                    sh 'terraform init prod'
                    sh 'terraform apply -auto-approve prod'
                }
            }
        }

        stage('Destroy') {
            steps {
                // Destroy resources after deployment in each environment
                sh 'terraform init dev'
                sh 'terraform destroy -auto-approve dev'
                sh 'terraform init test'
                sh 'terraform destroy -auto-approve test'
                sh 'terraform init stage'
                sh 'terraform destroy -auto-approve stage'
                sh 'terraform init prod'
                sh 'terraform destroy -auto-approve prod'
            }
        }
    }
}