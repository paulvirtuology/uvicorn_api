pipeline {
    agent any

    environment {
        VENV_DIR = "${WORKSPACE}/venv"
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning the repository...'
                checkout scm
            }
        }

        stage('Setup Python') {
            steps {
                echo 'Setting up Python virtual environment...'
                sh 'python3 -m venv ${VENV_DIR}'
                sh 'source ${VENV_DIR}/bin/activate && pip install --upgrade pip && pip install -r requirements.txt'
            }
        }

        stage('Run Tests') {
            steps {
                echo 'Running tests...'
                sh 'source ${VENV_DIR}/bin/activate && pytest tests/'
            }
        }

        stage('Run Application') {
            steps {
                echo 'Starting the FastAPI application...'
                sh 'source ${VENV_DIR}/bin/activate && uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload &'
                sh 'sleep 5'
                sh 'curl http://localhost:8000/health'
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            sh 'pkill -f uvicorn || true'
        }
    }
}
