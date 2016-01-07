FROM alpine:3.3
MAINTAINER Tung Ha "tunght13488@gmail.com"

RUN apk add --update curl \
  && curl -o glibc-2.21-r2.apk "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/8/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk" \
  && apk add --allow-untrusted glibc-2.21-r2.apk \
  && curl -o glibc-bin-2.21-r2.apk "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/8/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-bin-2.21-r2.apk" \
  && apk add --allow-untrusted glibc-bin-2.21-r2.apk \
  && /usr/glibc/usr/bin/ldconfig /lib /usr/glibc/usr/lib \
  && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf \
  && apk del curl \
  && rm -f glibc-2.21-r2.apk glibc-bin-2.21-r2.apk \
  && rm -rf /var/cache/apk/*

# Install common stuff
# - bash: essential, I don't want to use #!/bin/sh all the time
# - grep: looks like busybox grep is slow: http://matthewkwilliams.com/index.php/2015/04/19/docker-containers-smaller-is-not-always-better/
RUN apk add --update \
    bash \
    grep \
  && rm -rf /var/cache/apk/*
