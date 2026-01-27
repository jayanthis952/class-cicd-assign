pipeline{
    agent any
    environment{
        version = "1.0.${env.BUILD_NUMBER}"
    }
    stages{
        stage("SCM"){
            steps{
                git branch: "main", url: "https://github.com/jayanthis952/class-cicd-assign.git"
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar-k8s') {
                    sh """
                    mvn clean verify sonar:sonar \
                      -Dsonar.projectKey=calculator-java1 \
                      -Dsonar.projectName='calculator-java1' \
                      -Dsonar.host.url=http://18.212.138.196:30001 \
                      -Dsonar.token=sqp_20434f5173f5450780da8d942abd747e3063dfc9
                    """
                }
            }
        }

        stage("Docker build"){
            steps{
                sh """  
                docker build -t class-assign:${version} .
                """
            }
        }
        stage('Docker Push to ECR') {
            steps {
                sh """
                docker tag calculator-java:${version} 772317732952.dkr.ecr.us-east-1.amazonaws.com/calculator-java:${version}
                docker push 772317732952.dkr.ecr.us-east-1.amazonaws.com/calculator-java:${version}
                """
            }
        }

       stage("Deploy to ec2"){
           steps{
               
               sh """
                     ssh ubuntu@100.53.112.152  "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 772317732952.dkr.ecr.us-east-1.amazonaws.com
                      docker pull 772317732952.dkr.ecr.us-east-1.amazonaws.com/calculator-java:${version}
                      docker run -it -d 772317732952.dkr.ecr.us-east-1.amazonaws.com/calculator-java:${version}" 
               """
               
           }
       }
    
    }
}
