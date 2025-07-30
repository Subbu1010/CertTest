#!/bin/bash

# Build the Maven project
echo "Building Maven project..."
mvn clean package -DskipTests

# Build the Docker image
echo "Building Docker image..."
docker build -t certtest:latest .

# Run the Docker container
echo "Running Docker container..."
docker run -p 8080:8080 certtest:latest 