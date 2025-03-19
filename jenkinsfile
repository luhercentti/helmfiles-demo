pipeline {
    agent any

     triggers {
        pollSCM('H/5 * * * *') // Poll SCM cada 5 minutos para verificar cambios
    }

    environment {
        DOCKER_IMAGE = 'lhc-hello-app' // Nombre de la imagen
        DOCKER_TAG = 'latest'          // Tag de la imagen
        KUBE_CONTEXT = 'minikube'      // Contexto de Kubernetes
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Construir la imagen de Docker
                    sh "docker build -t ${env.DOCKER_IMAGE}:${env.DOCKER_TAG} ."
                }
            }
        }

        stage('Load Docker Image into Minikube') {
            steps {
                script {
                    // Cargar la imagen en Minikube
                    sh "minikube image load ${env.DOCKER_IMAGE}:${env.DOCKER_TAG}"
                }
            }
        }

        stage('Deploy with Helmfile') {
            steps {
                script {
                    // Ejecutar Helmfile para actualizar el despliegue
                    sh "helmfile --environment minikube apply"
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline ejecutado con éxito!'
        }
        failure {
            echo 'Pipeline falló!'
        }
    }
}