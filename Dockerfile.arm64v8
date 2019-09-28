FROM arm64v8/debian:buster-slim as builder

# Arm64v8 qemu
ADD qemu-aarch64-static /usr/bin

# Fluent Bit version
ENV FLB_MAJOR 1
ENV FLB_MINOR 2
ENV FLB_PATCH 2
ENV FLB_VERSION 1.2.2

ENV DEBIAN_FRONTEND noninteractive

ENV FLB_TARBALL http://github.com/fluent/fluent-bit/archive/v$FLB_VERSION.zip
RUN mkdir -p /fluent-bit/bin /fluent-bit/etc /fluent-bit/log /tmp/fluent-bit-master/

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      cmake \
      make \
      wget \
      unzip \
      libssl-dev \
      libasl-dev \
      libsasl2-dev \
      pkg-config \
      libsystemd-dev \
      zlib1g-dev \
      ca-certificates \
      flex \
      bison \
    && wget -O "/tmp/fluent-bit-${FLB_VERSION}.zip" ${FLB_TARBALL} \
    && cd /tmp && unzip "fluent-bit-$FLB_VERSION.zip" \
    && cd "fluent-bit-$FLB_VERSION"/build/ \
    && rm -rf /tmp/fluent-bit-$FLB_VERSION/build/*

WORKDIR /tmp/fluent-bit-$FLB_VERSION/build/
RUN cmake -DFLB_DEBUG=On \
          -DFLB_TRACE=Off \
          -DFLB_JEMALLOC=On \
          -DFLB_TLS=On \
          -DFLB_SHARED_LIB=Off \
          -DFLB_EXAMPLES=Off \
          -DFLB_HTTP_SERVER=On \
          -DFLB_IN_SYSTEMD=On \
          -DFLB_OUT_KAFKA=On ..

RUN make -j $(getconf _NPROCESSORS_ONLN)
RUN install bin/fluent-bit /fluent-bit/bin/

# Configuration files
COPY fluent-bit.conf \
     parsers.conf \
     parsers_java.conf \
     parsers_extra.conf \
     parsers_openstack.conf \
     parsers_cinder.conf \
     plugins.conf \
     /fluent-bit/etc/

FROM arm64v8/debian:buster-slim

# Arm64v8 qemu
ADD qemu-aarch64-static /usr/bin

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      libssl1.1 \
      libsasl2-2 \
      pkg-config \
      libsystemd0 \
      zlib1g \
      ca-certificates

COPY --from=builder /fluent-bit /fluent-bit

#
EXPOSE 2020

# Entry point
CMD ["/fluent-bit/bin/fluent-bit", "-c", "/fluent-bit/etc/fluent-bit.conf"]
