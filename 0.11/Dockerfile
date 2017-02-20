FROM alpine:3.4
MAINTAINER Eduardo Silva <eduardo@treasure-data.com>
LABEL Description="Fluent Bit docker image" Vendor="Fluent Organization" Version="1.1"

# Fluent Bit version
ENV FLB_MAJOR 0
ENV FLB_MINOR 11
ENV FLB_PATCH 0
ENV FLB_VERSION 0.11.0

# Do not split this into multiple RUN!
# Docker creates a layer for every RUN-Statement
# therefore an 'apk delete build*' has no effect
RUN apk --no-cache --update add \
                            build-base \
                            ca-certificates \
                            openssl \
                            cmake && \
    wget -O "/tmp/fluent-bit-$FLB_VERSION-dev.zip" "http://github.com/fluent/fluent-bit/archive/master.zip" && \
    cd /tmp && \
    unzip "fluent-bit-$FLB_VERSION-dev.zip" && \
    cd "fluent-bit-master/build/" && \
    cmake -DFLB_DEBUG=On -DFLB_TRACE=On ../ \
      -DCMAKE_INSTALL_PREFIX=/fluent-bit/ && \
    make && make install && \
    rm -rf /tmp/* /fluent-bit/include /fluent-bit/lib* && \
    apk del build-base openssl

RUN mkdir -p /fluent-bit/log
COPY fluent-bit.conf /fluent-bit/etc/
COPY parsers.conf /fluent-bit/etc/

CMD ["/fluent-bit/bin/fluent-bit", "-c", "/fluent-bit/etc/fluent-bit.conf"]
