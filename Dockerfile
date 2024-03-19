# Use Tomcat as the base image
FROM tomcat:9.0-jdk17-openjdk-slim AS build

# Set the working directory in the container
WORKDIR /usr/local/tomcat/webapps

# Copy the WAR file built from Maven
COPY target/**.*war .

# Expose port 8000
EXPOSE 8000

# Command to run Tomcat with the deployed application
CMD ["catalina.sh", "run"]
