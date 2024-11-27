#!/bin/bash

# to prevent the script from running more than once
if [ -f "/var/log/startup-script-ran" ]; then
  exit 0
fi

sudo apt update -y && sudo apt upgrade -y

sudo apt install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

sudo apt update -y
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

RANDOM_PASSWORD=$(openssl rand -base64 32)

mkdir -p /root/docker

cat >/root/docker/docker-compose.yml <<EOF
services:
  postgres:
    image: postgres:16
    restart: always
    environment:
      POSTGRES_USER: tutortoise
      POSTGRES_PASSWORD: $RANDOM_PASSWORD
      POSTGRES_DB: tutortoise
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
EOF

sudo docker compose -f /root/docker/docker-compose.yml up -d

touch "/var/log/startup-script-ran"
