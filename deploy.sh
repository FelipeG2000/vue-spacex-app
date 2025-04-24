#!/bin/bash

set -e

# Configuraciones
REGION="us-east-1"
STACK_NAME="spacex-backend"
REPO_NAME="spacex-frontend"
CLUSTER_NAME="spacex-frontend-cluster"
SERVICE_NAME="spacex-frontend-service"
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)

# 1. Obtener URL del backend desde CloudFormation
API_URL=$(aws cloudformation describe-stacks \
  --stack-name "$STACK_NAME" \
  --region "$REGION" \
  --query "Stacks[0].Outputs[?OutputKey=='SpaceXLaunchesApiEndpoint'].OutputValue" \
  --output text)

echo "✅ Backend URL: $API_URL"

# 2. Crear .env.production
echo "VITE_API_URL=${API_URL}" > .env.production
echo "✅ .env.production generado"

# 3. Construir imagen docker
docker build -t ${REPO_NAME}:latest .
echo "✅ Imagen Docker construida"

# 4. Login en ECR
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com

# 5. Tag
docker tag ${REPO_NAME}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPO_NAME}:latest

# 6. Push
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPO_NAME}:latest
echo "✅ Imagen subida a ECR"

# 7. Forzar nuevo deploy
aws ecs update-service \
  --cluster $CLUSTER_NAME \
  --service $SERVICE_NAME \
  --force-new-deployment \
  --region $REGION
echo "✅ Servicio ECS actualizado"
