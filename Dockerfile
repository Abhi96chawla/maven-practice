# # # Use Tomcat as the base image
# # FROM tomcat:9.0-jdk17-openjdk-slim AS build

# # # Set the working directory in the container
# # WORKDIR /usr/local/tomcat/webapps

# # COPY pom.xml .

# # RUN apt-get update && \
# #     apt-get install -y maven && \
# #     mvn clean package
    
# # # Copy the WAR file built from Maven
# # COPY . .

# # # Expose port 8000
# # EXPOSE 8000

# # # Command to run Tomcat with the deployed application
# # CMD ["catalina.sh", "run"]

# FROM tomcat:9.0-jdk17-openjdk-slim AS build
# ADD pom.xml .
# #COPY . .

# # Build the Maven project
# RUN mvn clean package
# #ADD target/*.war webapp.war
# EXPOSE 8000
# CMD ["catalina.sh", "run"]


FROM maven:3.5.2-jdk-8-alpine AS MAVEN_TOOL_CHAIN
#COPY pom.xml /tmp
COPY . .
WORKDIR /tmp/
RUN mvn package
FROM tomcat:9.0-jre8-alpine
COPY --from=MAVEN_TOOL_CHAIN /tmp/target/webapp*.war $CATALINA_HOME/webapps/webapp.war
EXPOSE 8000
 CMD ["catalina.sh", "run"]
