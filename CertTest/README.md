# CertTest Spring Boot Application

This is a Spring Boot microservice that exposes user data from an H2 in-memory database, designed for OpenShift deployment with environment variable configuration.

## Features

- H2 in-memory database with pre-loaded sample data
- REST API endpoints for CRUD operations on users
- H2 Console for database management
- Docker support for containerization
- **OpenShift compatible** with proper security context and health checks
- Spring Boot Actuator for monitoring and health checks
- **Environment variable configuration** for database settings

## Quick Start

### Prerequisites
- Java 17
- Maven 3.6+
- Docker (optional)
- OpenShift CLI (for OpenShift deployment)

### Running Locally

1. **Build and run with Maven:**
   ```bash
   mvn clean package
   java -jar target/certtest-0.0.1-SNAPSHOT.jar
   ```

2. **Or run directly with Maven:**
   ```bash
   mvn spring-boot:run
   ```

3. **With custom environment variables:**
   ```bash
   # Windows PowerShell
   $env:DB_PASSWORD="YourPassword"; mvn spring-boot:run
   
   # Linux/macOS
   DB_PASSWORD=YourPassword mvn spring-boot:run
   ```

### Running with Docker

1. **Build and run with Docker:**
   ```bash
   # On Windows
   .\build-and-run.ps1
   
   # On Linux/macOS
   chmod +x build-and-run.sh
   ./build-and-run.sh
   ```

2. **With environment variables:**
   ```bash
   docker run -p 8080:8080 -e DB_PASSWORD=YourPassword certtest:latest
   ```

## OpenShift Deployment

### Prerequisites for OpenShift
- OpenShift CLI (`oc`) installed and configured
- Access to OpenShift cluster
- Docker registry access

### Environment Variables

The application uses the following environment variables:

| Variable | Description | Default Value |
|----------|-------------|---------------|
| `DB_URL` | Database connection URL | `jdbc:h2:mem:testdb` |
| `DB_USERNAME` | Database username | `sa` |
| `DB_PASSWORD` | Database password | `Apple@2020` |
| `DB_DRIVER` | Database driver class | `org.h2.Driver` |

### Deployment Steps

1. **Login to OpenShift:**
   ```bash
   oc login --token=<your-token> --server=<your-server>
   ```

2. **Create a new project (if needed):**
   ```bash
   oc new-project certtest-project
   ```

3. **Build and deploy:**
   ```bash
   chmod +x openshift-deploy.sh
   ./openshift-deploy.sh
   ```

4. **Or deploy manually:**
   ```bash
   # Build the application
   mvn clean package -DskipTests
   
   # Build Docker image
   docker build -t certtest:latest .
   
   # Deploy with Helm
   helm install certtest ./helm \
     --set database.password=YourSecurePassword
   ```

### OpenShift Features

- **Security Context:** Runs as non-root user (UID 185)
- **Health Checks:** Liveness and readiness probes configured
- **Resource Limits:** CPU and memory limits set
- **Route:** External access via OpenShift Route
- **Actuator Endpoints:** Health, info, and metrics available
- **Secrets Management:** Database password stored in Kubernetes Secret
- **ConfigMaps:** Non-sensitive configuration in ConfigMap

### Security Features

- **Database Password:** Stored in OpenShift Secret (base64 encoded)
- **Non-sensitive Data:** Stored in ConfigMap
- **Environment Variables:** All database configuration via environment variables
- **No Hardcoded Secrets:** Passwords are never hardcoded in the application

## Access Points

### Local Development
- **Application:** http://localhost:8080
- **H2 Console:** http://localhost:8080/h2-console
- **API Endpoints:** http://localhost:8080/api/users
- **Health Check:** http://localhost:8080/actuator/health

### OpenShift Deployment
- **Application:** https://certtest-app.apps.openshift.com
- **API Endpoints:** https://certtest-app.apps.openshift.com/api/users
- **Health Check:** https://certtest-app.apps.openshift.com/actuator/health

## API Endpoints

- `GET /api/users` - Get all users
- `GET /api/users/{id}` - Get user by ID
- `POST /api/users` - Create new user
- `PUT /api/users/{id}` - Update user
- `DELETE /api/users/{id}` - Delete user

## H2 Database Console

1. Open http://localhost:8080/h2-console
2. Use these connection settings:
   - **JDBC URL:** `jdbc:h2:mem:testdb`
   - **Username:** `sa`
   - **Password:** `Apple@2020` (or your custom password)

## Sample Data

The application comes with 5 sample users pre-loaded in the database:
- john_doe (john.doe@example.com)
- jane_smith (jane.smith@example.com)
- bob_wilson (bob.wilson@example.com)
- alice_johnson (alice.johnson@example.com)
- charlie_brown (charlie.brown@example.com)

## Database Schema

The `tbl_users` table has the following structure:
- `id` (BIGINT, AUTO_INCREMENT, PRIMARY KEY)
- `username` (VARCHAR(255), NOT NULL)
- `email` (VARCHAR(255), NOT NULL)

## OpenShift Configuration

### Security
- Runs as non-root user (UID 185)
- Proper security context configured
- Resource limits and requests set
- Database password stored in Secret

### Monitoring
- Spring Boot Actuator enabled
- Health checks configured
- Metrics endpoint available

### Networking
- Service exposed on port 8080
- OpenShift Route for external access
- TLS termination configured

### Environment Variables
- All database configuration via environment variables
- Fallback values for local development
- Secure password management through OpenShift Secrets 