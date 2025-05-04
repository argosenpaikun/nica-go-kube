FROM golang:latest AS build
LABEL maintainer="Affian Onn <affianonn@hotmail.com>"
LABEL org.opencontainers.image.source=https://github.com/argosenpaikun/nica-go-kube

WORKDIR /compose/hello-docker

COPY src/hello-world.go main.go

RUN go mod init go-nica && go mod tidy
RUN go get github.com/shirou/gopsutil/cpu
RUN CGO_ENABLED=0 go build -o hello main.go

FROM scratch
COPY --from=build /compose/hello-docker/hello /usr/local/bin/hello

EXPOSE 8081
CMD ["/usr/local/bin/hello"]