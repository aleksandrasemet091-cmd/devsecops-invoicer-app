# Этап 1: Сборка
FROM golang:1.22-alpine AS builder

WORKDIR /app

# Копируем весь код
COPY . .

# Компилируем в бинарный файл invoicer
RUN CGO_ENABLED=0 GOOS=linux go build -o invoicer .

# Этап 2: Финальный образ
FROM alpine:latest

# Создаём непривилегированного пользователя
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /home/appuser/app
RUN chown appuser:appgroup /home/appuser/app

# Копируем бинарник из сборки
COPY --from=builder --chown=appuser:appgroup /app/invoicer .

# Переключаемся на пользователя
USER appuser

EXPOSE 8080

CMD ["./invoicer"]