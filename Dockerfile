#build grpc_php_plugin binary
FROM ubuntu as build-plugin
WORKDIR /tmp

ARG GRPC_PLUGIN_VERSION=1.28.1

RUN apt-get update
RUN apt-get install -y git zip g++ make autoconf libtool
RUN git clone -b v${GRPC_PLUGIN_VERSION} https://github.com/grpc/grpc
RUN cd grpc && git submodule update --init && make grpc_php_plugin

#build php image
FROM php:7.4-cli
WORKDIR /tmp/build

ARG RR_VERSION=1.2.1
ARG PROTOBUF_VERSION=3.4.0

RUN apt-get update
RUN apt-get install -y zlib1g-dev git zip libzip-dev

#plugin
COPY --from=build-plugin /tmp/grpc/bins/opt/grpc_php_plugin /usr/local/bin/grpc_php_plugin

#protoc
RUN curl -o protoc.zip -LOk https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOBUF_VERSION}/protoc-${PROTOBUF_VERSION}-linux-x86_64.zip
RUN unzip protoc.zip
RUN cp ./bin/protoc /usr/local/bin/protoc

#protoc plugin for road runner
RUN curl -sL https://github.com/spiral/php-grpc/releases/download/v${RR_VERSION}/protoc-gen-php-grpc-${RR_VERSION}-linux-amd64.tar.gz | tar xz
RUN cp ./protoc-gen-php-grpc-${RR_VERSION}-linux-amd64/protoc-gen-php-grpc /usr/local/bin/protoc-gen-php-grpc

#grpc road runner
RUN curl -sL https://github.com/spiral/php-grpc/releases/download/v${RR_VERSION}/rr-grpc-${RR_VERSION}-linux-amd64.tar.gz | tar xz
RUN cp ./rr-grpc-${RR_VERSION}-linux-amd64/rr-grpc /usr/local/bin/rr-grpc

WORKDIR /app

RUN docker-php-ext-install pcntl zip

RUN pecl install protobuf \
   && docker-php-ext-enable protobuf

RUN pecl install grpc \
   && docker-php-ext-enable grpc

RUN curl https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/build
