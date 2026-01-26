FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY assign-2/target/*jar app.jar
CMD ["java","-jar","app.jar"]
