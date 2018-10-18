# =============================================================================
# build image
# =============================================================================
FROM alpine:3.8 as build

RUN apk update && apk add build-base \
  git \
  cmake \
  wget \
  linux-headers

ENV FLB_MAJOR 0
ENV FLB_MINOR 14
ENV FLB_PATCH 4
ENV FLB_VERSION ${FLB_MAJOR}.${FLB_MINOR}.${FLB_PATCH}

ENV FLB_TARBALL http://github.com/fluent/fluent-bit/archive/v$FLB_VERSION.zip

RUN mkdir -p /fluent-bit/bin /fluent-bit/etc /fluent-bit/log /tmp/src/

RUN wget -O "/tmp/fluent-bit-${FLB_VERSION}.zip" ${FLB_TARBALL} \
    && cd /tmp && unzip "fluent-bit-$FLB_VERSION.zip" \
    && cd "fluent-bit-$FLB_VERSION"/build/ \
    && cmake -DFLB_DEBUG=On \
          -DFLB_TRACE=Off \
          -DFLB_JEMALLOC=On \
          -DFLB_BUFFERING=On \
          -DFLB_TLS=On \
          -DFLB_SHARED_LIB=Off \
          -DFLB_EXAMPLES=Off \
          -DFLB_HTTP_SERVER=On \
          -DFLB_OUT_KAFKA=On .. \
    && make \
    && install bin/fluent-bit /fluent-bit/bin/

RUN cp -r /tmp/fluent-bit-$FLB_VERSION/conf/*.conf /fluent-bit/etc/

# =============================================================================
# distribute
# =============================================================================
FROM alpine:3.8

RUN apk update && apk --no-cache add \
  libgcc \
  ca-certificates \
  && rm -rf /var/cache/apk/*

COPY --from=build /fluent-bit /fluent-bit

EXPOSE 2020

# Entry point
CMD ["/fluent-bit/bin/fluent-bit", "-c", "/fluent-bit/etc/fluent-bit.conf"]
