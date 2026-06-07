FROM golang:1.22-alpine

WORKDIR /app

COPY . .

# Скачиваем зависимости
RUN go mod download

# Собираем
RUN CGO_ENABLED=0 GOOS=linux go build -o invoicer .

EXPOSE 8080

CMD ["./invoicer"]