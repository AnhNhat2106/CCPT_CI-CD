# --- GIAI ĐOẠN 1: BUILD ---
FROM maven:3.9.11-eclipse-temurin-17 AS builder
WORKDIR /app
COPY . .
# Biên dịch code thành file .jar (bỏ qua chạy thửtest để build nhanh)
RUN mvn package -DskipTests

# --- GIAI ĐOẠN 2: RUN ---
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
# Chỉ lấy file .jar từ builder (GĐ1)
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 80
# Đổi port Spring Boot sang 80 để khớp với Slot S2 của trường
ENTRYPOINT ["java", "-jar", "app.jar", "--server.port=80"]