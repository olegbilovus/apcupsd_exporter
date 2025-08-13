FROM golang:1.24-alpine AS build-env

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o app

# Run stage
FROM scratch

WORKDIR /app
COPY --from=build-env /app/app /app/app

EXPOSE 9162
ENTRYPOINT [ "./app" ]

