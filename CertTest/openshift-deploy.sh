#!/bin/bash

# OpenShift Deployment Script for CertTest Application

echo "Building application..."
mvn clean package -DskipTests

echo "Building Docker image..."
docker build -t certtest:latest .

echo "Tagging image for OpenShift registry..."
# Replace with your OpenShift registry URL
docker tag certtest:latest your-openshift-registry/certtest:latest

echo "Pushing image to OpenShift registry..."
# Replace with your OpenShift registry URL
docker push your-openshift-registry/certtest:latest

echo "Creating OpenShift Secret for database password..."
# Create the secret manually (optional - Helm will create it)
oc apply -f openshift-secret.yaml

echo "Deploying to OpenShift using Helm..."
helm install certtest ./helm \
  --set image.repository=your-openshift-registry/certtest \
  --set image.tag=latest \
  --set route.host=certtest-app \
  --set route.domain=apps.openshift.com \
  --set database.password=Apple@2020

echo "Deployment completed!"
echo "Access your application at: https://certtest-app.apps.openshift.com"
echo ""
echo "Environment variables set:"
echo "- DB_URL: jdbc:h2:mem:testdb"
echo "- DB_USERNAME: sa"
echo "- DB_PASSWORD: [from OpenShift Secret]"
echo "- DB_DRIVER: org.h2.Driver" 