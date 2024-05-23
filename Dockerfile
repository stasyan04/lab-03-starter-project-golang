FROM golang:1.19-alpine AS build

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -ldflags '-extldflags "-static"' -o fizzbuzz

FROM gcr.io/distroless/static-debian12

COPY --from=build /app/fizzbuzz /fizzbuzz

ENTRYPOINT ["/fizzbuzz"]