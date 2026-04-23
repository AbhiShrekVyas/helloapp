FROM eclipse-temurin:17-jre-alpine
# Start from: Java 17 runtime on Alpine Linux (tiny OS, only 5MB)

WORKDIR /app
# Set working directory inside the container

COPY target/helloapp-0.0.1-SNAPSHOT.jar app.jar
# Copy your .jar from your machine into the container

EXPOSE 8080
# Document that this app listens on port 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
# Command to run when the container starts
