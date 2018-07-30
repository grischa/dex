FROM alpine:3.8
# Dex connectors, such as GitHub and Google logins require root certificates.
# Proper installations should manage those certificates, but it's a bad user
# experience when this doesn't work out of the box.
#
# OpenSSL is required so wget can query HTTPS endpoints for health checking.
RUN apk add --update ca-certificates openssl

COPY ./bin/dex /usr/local/bin/dex
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

# Import frontend assets and set the correct CWD directory so the assets
# are in the default path.
COPY ./web /web
WORKDIR /

ENTRYPOINT ["dex"]
