Examples of pipeline

1. Go to Jenkins main console
2. Click New Item on left hand side
3. Give a name of job ---> Pipeline ---> Ok
4. Build Trigger'ı göster
- Burada farklı alternatifler vardır. Bunlardan biri github webhookdur mesela. Ya da jenkinse belli bir periyodda pipeline i yap da diyebilirsiniz. Mesela her 5 dk da bir ya da her gün ya da her ay.
Burada build periodicaly i seçerseniz bu şekilde periyodları belirleyebilirsiniz.
herbir * bir anlama gelir. bunları göster... ? ne basılırsa açıklama çıkar. 

- Build after orher projects are build. 
--> watch this job kısmında bir adres verilirse o job execute edildiğinde bu jenkins file çalışmaya başlar.

Built  5 * * * * --> Her 5 dakikada bir demek.

5. Pipeline

Pipeline script ---> Select Hello World piplene code on right dropdown menu next to script location

---> its going to use any agent --> it meansany available aganet is ok
click apply and save 
--> Show list of jobs
--> Click Build now
---> Console output'a gel ve göster
    - Jenkins herbir job için  için /var/lib/jenkins/workspace klasörünün altınd bir folder oluşturur. All configurations are included by this folder.

Tekrar configuration a tıkla ve aşağıdakileri söyleyebilirsin.

2. Ben şu an Jenkins' her dakika periyodik olarak benim job'u tekrar execute et diyorum. Şunu da diyebilirm; Jenkins benim Github repo'mu gözle ve orada bir değişiklik olduğunda o değişikliği takip et ve onu oradan çek ve execute et. Ya da bir pull request olduğunda bunu yap da diyebilirim. 

Poll SCM --> 5 * * * * Her 5 dakikada benim 
In Jenkins, SCM stands for "Source Code Management".This option instructs Jenkins to obtain your Pipeline from Source Control Management (SCM), which will be your locally cloned Git repository.


6. Daha complex bir şey yapalım

Docker'ı agent olarak kullanalım

---> Click Manage Jenkins on the Main page on left hand side
---> Manage Nodes and Clouds
    --> Burada jenkins master görülecektir.  
--->1.35 -1.40 arasını izle

--------------------------
pipeline {
    agent {
        docker 'node:14-alpine'
    }
    

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
        stage('Test the NodeJS') {
            steps {
                sh 'node --version'
                sh 'mkdir serdar'
                sh 'cd serdar'
            }
        }
    }
}

-----------------------




-------------
pipeline {
    agent {
        label 'master'
    }
    
    stages {
        stage('Check Docker') {
            steps {
                sh 'docker --version'
            }
        }
        stage('List of ımages') {
            steps {
                sh 'docker image ls'
            }
        }
    }
}
------




--------------
pipeline {
    agent {
        label 'master'
    }
    
    stages {
        stage('Check Docker') {
            steps {
                sh 'aws --version'
            }
        }
        stage('List of ımages') {
            steps {
                sh """
                aws ecr create-repository \
                  --repository-name test \
                  --image-scanning-configuration scanOnPush=false \
                  --image-tag-mutability MUTABLE \
                  --region us-east-1
                """
            }
        }
    }
}

#Bunu ikinci defa çalıştır ve hata verdiğini göster. Bu hata ilk build de repo oluştuğundan dolayı aynı isimli tekrar repo oluşturamamasından kaynaklanır

---------------

pipeline {
    agent {
        label 'master'
    }
    
    stages {
        stage('Check AWS CLI') {
            steps {
                sh 'aws --version'
            }
        }
        stage('Creating Repo') {
            steps {
                sh """
                aws ecr create-repository \
                  --repository-name test \
                  --image-scanning-configuration scanOnPush=false \
                  --image-tag-mutability MUTABLE \
                  --region us-east-1
                """
            }
        }
    }
    post {
        always {
            echo 'Goodbye ALL... Please come back soon'
        }
        failure {
            echo 'Sorry but you messed up...'
        }
        success {
            echo 'You are the man/woman...'
        }
    }
}

---> Documentation: www.jenkins.io/doc/book/pipeline/getting-started/
---> www.jenkins.io/doc/book/pipeline/syntax/#scripted-pipeline







Declerative Pipeline and Scripting Pipeline
