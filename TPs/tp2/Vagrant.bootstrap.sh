#!/bin/bash

set -e

echo "=== Actualizando paquetes ==="
apt-get update

echo "=== Instalando Docker ==="
apt-get install -y docker.io docker-compose-v2

echo "=== Habilitando Docker ==="
systemctl enable docker
systemctl start docker

echo "=== Verificando Docker ==="
docker --version
docker compose version

echo "=== Levantando la aplicación ==="
cd /vagrant/docker
docker compose up --build -d

echo "=== Contenedores ==="
docker compose ps