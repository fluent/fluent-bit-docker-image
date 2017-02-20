FROM alpine:3.4
MAINTAINER Eduardo Silva <eduardo@treasure-data.com>
LABEL Description="Fluent Bit docker image" Vendor="Fluent Organization" Version="1.1"

# Fluent Bit version
ENV FLB_MAJOR 0
ENV FLB_MINOR 10
ENV FLB_PATCH 1
ENV FLB_VERSION 0.10.1
ENV FLB_DOWNLOAD_SHA256 0a2564dda1410ec756521334df7ffe94d97b475a4ea4c2a7fabffcc2503fab61

# Do not split this into multiple RUN!
# Docker creates a layer for every RUN-Statement
# therefore an 'apk delete build*' has no effect
RUN apk --no-cache --update add \
                            build-base \
                            ca-certificates \
                            cmake && \
    wget -O "/tmp/fluent-bit-$FLB_VERSION.tar.gz" "http://fluentbit.io/releases/$FLB_MAJOR.$FLB_MINOR/fluent-bit-$FLB_VERSION.tar.gz" && \
    cd /tmp && \
    echo "$FLB_DOWNLOAD_SHA256 *fluent-bit-$FLB_VERSION.tar.gz" | sha256sum -c - && \
    tar zxfv "fluent-bit-$FLB_VERSION.tar.gz" && \
    cd "fluent-bit-$FLB_VERSION/build/" && \
    cmake -DFLB_DEBUG=On -DFLB_TRACE=On ../ \
      -DCMAKE_INSTALL_PREFIX=/fluent-bit/ && \
    make && make install && \
    rm -rf /tmp/* && apk del build-base

RUN mkdir -p /fluent-bit/log
COPY fluent-bit.conf /fluent-bit/etc/

CMD ["/fluent-bit/bin/fluent-bit", "-c", "/fluent-bit/etc/fluent-bit.conf"]
