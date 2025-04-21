# 构建阶段
FROM openjdk:17-slim AS build
ENV HOME=/usr/app
WORKDIR $HOME

# 复制文件并显式设置 mvnw 权限
COPY . .
RUN chmod +x ./mvnw  # 关键修复：添加执行权限

# 使用缓存构建
RUN --mount=type=cache,target=/root/.m2 ./mvnw clean package  # 移除 -f 参数（WORKDIR 已是项目根目录）

# 打包阶段（保持不变）
FROM openjdk:17-slim
ARG JAR_FILE=/usr/app/target/*.jar
COPY --from=build $JAR_FILE /app/runner.jar
EXPOSE 8081
ENTRYPOINT java -jar /app/runner.jar