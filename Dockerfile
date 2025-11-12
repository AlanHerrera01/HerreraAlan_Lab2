# Usa la imagen de Eclipse Temurin (reemplazo oficial de OpenJDK)
FROM eclipse-temurin:17-jdk-alpine

# Directorio de trabajo
WORKDIR /app

# Copia los archivos de configuración de Gradle
COPY build.gradle settings.gradle gradlew ./
COPY gradle ./gradle

# Descarga las dependencias
RUN chmod +x ./gradlew
RUN ./gradlew dependencies

# Copia el código fuente
COPY src ./src

# Construye la aplicación
RUN ./gradlew clean build -x test

# Puerto de la aplicación (Render asigna dinámicamente)
EXPOSE 8080

# Comando para ejecutar la aplicación
# Render proporciona PORT como variable de entorno
CMD ["sh", "-c", "java -jar build/libs/spring-lab-0.0.1-SNAPSHOT.jar --server.port=${PORT:-8080}"]
