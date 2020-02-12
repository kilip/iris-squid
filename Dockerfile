FROM alpine:latest AS builder

ARG SQUID_VERSION
ARG SQUID_CONFIGURE
LABEL author="Anthonius Munthi <https://itstoni.com>"
LABEL version="Squid: ${SQUID_VERSION}"

RUN apk update \
    && apk add --virtual \
       build-dependencies \
       build-base \
       gcc \
       wget \
       perl \
       openssl-dev \
    && apk add --no-cache \
       bash

WORKDIR /tmp
RUN mkdir /squid
RUN wget -O squid.tar.gz http://www.squid-cache.org/Versions/v5/squid-${SQUID_VERSION}.tar.gz
RUN tar xzf squid.tar.gz \
    && ls -l \
    && cd squid-${SQUID_VERSION} \
    && ./configure ${SQUID_CONFIGURE} \
    && make \
    && make install \
    && make distclean \
    && rm squid.tar.gz

RUN apk del --purge \
    build-dependencies

# Real container
FROM alpine:latest

WORKDIR /
COPY --from=builder /squid /squid
COPY bin/entrypoint.sh /bin/entrypoint

ENTRYPOINT [ "/bin/entrypoint" ]