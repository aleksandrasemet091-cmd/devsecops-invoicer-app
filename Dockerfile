FROM golang:1.22-alpine

WORKDIR /app

# Копируем go.mod (go.sum может отсутствовать)
COPY go.mod ./
RUN go mod download

# Копируем остальной код
COPY . .

RUN go build -o invoicer .

EXPOSE 8080

CMD ["./invoicer"]