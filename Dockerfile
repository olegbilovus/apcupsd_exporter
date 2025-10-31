FROM golang:1.25-alpine AS build-env

WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY . .
WORKDIR /src/cmd/apcupsd_exporter
RUN go build -o /app

# Run stage
FROM scratch

COPY --from=build-env  /app /app

EXPOSE 9162
ENTRYPOINT [ "/app" ]

