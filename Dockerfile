FROM resin/rpi-raspbian:latest

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
 curl gcc libc6-dev libc6 \
 --no-install-recommends

ENV GO_VERSION 1.11

RUN curl -sSL https://storage.googleapis.com/golang/go$GO_VERSION.linux-armv6l.tar.gz -o /tmp/go.tar.gz && \
    tar -C /usr/local -vxzf /tmp/go.tar.gz && \
    rm /tmp/go.tar.gz

ENV PATH /go/bin:/usr/local/go/bin:$PATH
ENV GOPATH /go:/go/src/app/_gopath

RUN mkdir -p /go/src/app /go/bin && chmod -R 777 /go

RUN ln -s /go/src/app /app
WORKDIR /go/src/app

LABEL go_version=$GO_VERSION

CMD ["go-wrapper", "run"]
