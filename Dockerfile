FROM golang:alpine

WORKDIR /app

COPY . .

RUN go mod download

RUN go build

WORKDIR /app/cmd/apcupsd_exporter

RUN go build

EXPOSE 9162

ENTRYPOINT [ "./apcupsd_exporter" ]

