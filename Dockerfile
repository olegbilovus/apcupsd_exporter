FROM golang:alpine AS build-env
WORKDIR /src
COPY . .

RUN go mod download
RUN go build

WORKDIR /src/cmd/apcupsd_exporter
RUN go build

# Run stage
FROM alpine

WORKDIR /app
COPY --from=build-env /src/cmd/apcupsd_exporter/apcupsd_exporter /app/apcupsd_exporter

EXPOSE 9162
ENTRYPOINT [ "./apcupsd_exporter" ]

