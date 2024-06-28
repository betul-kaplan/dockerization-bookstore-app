#!/bin/bash
dnf update -y
dnf install -y git
dnf install -y docker
systemctl start docker
systemctl enable docker
usermod -a -G docker ec2-user
newgrp docker
curl -SL https://github.com/docker/compose/releases/download/v2.20.3/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
cd /home/ec2-user
TOKEN=${user-data-git-token}
USER=${user-data-git-name}
git clone https://$TOKEN@github.com/$USER/bookstore-api-repo.git
cd /home/ec2-user/bookstore-api-repo
docker build -t bookstoreapi:latest .
docker-compose up -d