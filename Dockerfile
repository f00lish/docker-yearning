FROM alpine:latest

LABEL maintainer="f00lish-2020/02/24"

RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2; \
    echo "http://mirrors.ustc.edu.cn/alpine/v3.3/main/" > /etc/apk/repositories; \
    apk add --no-cache tzdata; \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
    echo "Asia/Shanghai" >> /etc/timezone; \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

EXPOSE 8000

ARG YEARNING_VER="2.1.9"
ARG YEARNING_URL="https://github.com/cookieY/Yearning/releases/download/v${YEARNING_VER}/Yearning-${YEARNING_VER}.linux-amd64.zip"
RUN wget -cqO yearning.zip $YEARNING_URL; \
    unzip yearning.zip -d /; \
    rm -f yearning.zip; \
    rm -f /Yearning-go/dist.zip

WORKDIR /Yearning-go/

ENTRYPOINT  ["./Yearning"]

CMD ["-m", "-s"]
