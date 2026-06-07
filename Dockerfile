FROM golang:1.22-alpine

WORKDIR /app

# Копируем весь код (включая папку vendor)
COPY . .

# Собираем без модулей, используя vendor
RUN CGO_ENABLED=0 GOOS=linux go build -mod=vendor -o invoicer .

EXPOSE 8080

CMD ["./invoicer"]