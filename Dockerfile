# Usar uma imagem base do Maven para compilar o projeto
FROM maven:3.8.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copiar o arquivo pom.xml e o diretório src para o diretório de trabalho
COPY pom.xml .
COPY src ./src

# Instalar as dependências do projeto e compilar o código
RUN mvn clean package -DskipTests

# Usar uma imagem base do OpenJDK para executar o projeto
FROM openjdk:17-jdk-alpine
WORKDIR /app

# Copiar o JAR gerado da etapa de build para o diretório de trabalho
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar app.jar

# Informar que a aplicação usa a porta 8081
EXPOSE 8082

# Comando para executar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]
