FROM registry.access.redhat.com/ubi8/openjdk-17:latest

# Set the working directory
WORKDIR /deployments

# Copy the JAR file
COPY target/certtest-0.0.1-SNAPSHOT.jar app.jar

# Set the DB_PWD environment variable
ENV DB_PWD=Test1234

# Expose port 8080
EXPOSE 8080

# Set user to run as non-root (OpenShift requirement)
USER 185

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"] 