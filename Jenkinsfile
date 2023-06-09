#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage("Create an EKS Cluster") {
            steps {
                script {
                    dir('terraform') {
                        sh "terraform init -reconfigure"
                        sh "terraform apply -auto-approve"
                        sh "terraform destroy -auto-approve"
                    }
                }
            }
        }
        stage("Deploy to EKS") {
            steps {
                script {
                    dir('kubernetes') {
                        sh "aws eks update-kubeconfig --name myapp-eks-cluster"
                        sh "kubectl apply -f complete-demo.yaml"
                        sh "kubectl apply -f nginx-deployment.yaml"
                        sh "kubectl apply -f nginx-service.yaml"
                        sh "kubectl get pods"
                        sh "kubectl get svc"
                    }
                }
            }
        } 
        stage('Prometheus and Granfana Deployment') {
            steps {
                script {
                    dir('kubernetes') {
                        sh "kubectl apply -f prometheus-configmap.yaml"
                        sh "kubectl apply -f prometheus-deployment.yaml"
                        sh "kubectl apply -f prometheus-service.yaml"
                        sh "kubectl apply -f grafana-deployment.yaml"
                        sh "kubectl apply -f grafana-service.yaml"
                        sh "kubectl get pods"
                        sh "kubectl get svc"
                }
            }
        }
        }
    }
}
