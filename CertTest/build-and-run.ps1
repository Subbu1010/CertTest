# Build the Maven project
Write-Host "Building Maven project..." -ForegroundColor Green
mvn clean package -DskipTests

# Build the Docker image
Write-Host "Building Docker image..." -ForegroundColor Green
docker build -t certtest:latest .

# Run the Docker container
Write-Host "Running Docker container..." -ForegroundColor Green
docker run -p 8080:8080 certtest:latest 