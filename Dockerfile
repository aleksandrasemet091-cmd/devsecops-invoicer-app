FROM golang:1.22-alpine

WORKDIR /app

COPY . .

RUN go build -o invoicer .

EXPOSE 8080

CMD ["./invoicer"]