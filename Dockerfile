ARG GO_VERSION=1.14
FROM golang:${GO_VERSION} AS builder

WORKDIR /build
ADD . /build

RUN CGO_ENABLED=0 go build cmd/dht22-exporter/dht22-exporter.go

FROM scratch
COPY --from=builder /build/dht22-exporter /dht22-exporter
LABEL maintainer="Stephan Fudeus <github@mails.fudeus.net>"

ENTRYPOINT ["/dht22-exporter"]
EXPOSE 8080
