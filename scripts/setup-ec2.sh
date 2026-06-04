#!/usr/bin/env bash
# Paso 5: requisitos en la EC2 frontend (Amazon Linux 2023 / ec2-user).
# Ejecutar una sola vez: bash scripts/setup-ec2.sh

set -euo pipefail

if ! command -v git >/dev/null 2>&1; then
  sudo dnf install -y git
fi

if ! command -v docker >/dev/null 2>&1; then
  sudo dnf install -y docker
  sudo systemctl enable docker
  sudo systemctl start docker
  sudo usermod -aG docker "$USER"
  echo "Docker instalado. Cierra sesión SSH y vuelve a entrar para usar docker sin sudo."
fi

if ! docker compose version >/dev/null 2>&1; then
  sudo dnf install -y docker-compose-plugin
fi

echo "Requisitos listos:"
echo "  - git: $(git --version)"
echo "  - docker: $(docker --version)"
echo "  - docker compose: $(docker compose version)"
