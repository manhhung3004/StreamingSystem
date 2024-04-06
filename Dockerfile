# Use a base image with Java 11 and Maven installed
FROM maven:3.8.4-openjdk-11 AS builder

# Copy the Maven settings file (if any)
COPY pom.xml /root/.m2/settings.xml

# Copy the project files into the container
COPY . /app

# Set the working directory
WORKDIR /app

# Build the project
RUN mvn clean package -DskipTests

# Use a lightweight base image for running the application
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory
WORKDIR /app

# Copy the JAR file from the builder stage
COPY --from=builder /app/target/FlinkCommerce-1.0-SNAPSHOT.jar /app/FlinkCommerce.jar

# Command to run the application
CMD ["java", "-jar", "FlinkCommerce.jar"]
