#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

printf "\n"

echo "Starting Jenkins container..."

docker-compose up -d

printf "\n"

echo "Jenkins is available at localhost:8080"
echo "Initial admin password:"

printf "\n"

docker-compose exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

printf "\n"