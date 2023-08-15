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
                        // Deploy to the Dev environment using Terraform
                        sh 'terraform init -reconfigure'
                        echo "Terraform action is --> ${action}"
                        sh ("terraform ${action} --auto-approve")
                    }
                }
            }
        }
    }
}
        