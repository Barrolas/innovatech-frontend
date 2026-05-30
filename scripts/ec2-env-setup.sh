#!/usr/bin/env bash
# Paso 4: crear .env de producción en la EC2 (una sola vez).
# Ejecutar desde la raíz del repo clonado: bash scripts/ec2-env-setup.sh

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="$ROOT_DIR/.env"
TEMPLATE="$ROOT_DIR/.env.production.example"

if [ ! -f "$TEMPLATE" ]; then
  echo "No se encontró $TEMPLATE"
  exit 1
fi

if [ -f "$ENV_FILE" ]; then
  echo "Ya existe $ENV_FILE. Edítalo manualmente si necesitas cambiar los upstreams."
  exit 0
fi

cp "$TEMPLATE" "$ENV_FILE"
echo "Creado $ENV_FILE desde .env.production.example"
echo "Edita las IPs privadas del backend antes del primer deploy:"
echo "  nano $ENV_FILE"
