# Этап 1: Сборка (build)
FROM golang:1.22-alpine AS builder

WORKDIR /app

# Копируем весь код
COPY . .

# Компилируем приложение (правильная команда!)
RUN CGO_ENABLED=0 GOOS=linux go build -mod=vendor -o invoicer .

# Этап 2: Финальный образ
FROM alpine:latest

# Создаём непривилегированного пользователя
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /home/appuser/app
RUN chown appuser:appgroup /home/appuser/app

# Копируем бинарник
COPY --from=builder --chown=appuser:appgroup /app/invoicer .

# Переключаемся на непривилегированного пользователя
USER appuser

EXPOSE 8080

CMD ["./invoicer"]