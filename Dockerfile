# Step 1: Build stage
FROM maven:3.9.5-eclipse-temurin-17 AS builder

# Set working directory
WORKDIR /app

# Copy pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the project and package the JAR
RUN mvn clean package -DskipTests

# Step 2: Runtime stage
FROM eclipse-temurin:17-jre-alpine

# Set working directory
WORKDIR /app

# Copy the JAR from builder and rename to app.jar
COPY --from=builder /app/target/*.jar app.jar

# Expose application port
EXPOSE 8080

# Run the JAR
CMD ["java", "-jar", "app.jar"]
