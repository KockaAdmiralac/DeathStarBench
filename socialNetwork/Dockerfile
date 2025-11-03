FROM ubuntu:16.04 AS builder

ARG LIB_MONGOC_VERSION=1.15.0
ARG LIB_THRIFT_VERSION=0.12.0
ARG LIB_JSON_VERSION=3.6.1
ARG LIB_JAEGER_VERSION=0.4.2
ARG LIB_YAML_VERSION=0.6.2
ARG LIB_OPENTRACING_VERSION=1.5.1
ARG LIB_CPP_JWT_VERSION=1.1.1
ARG LIB_CPP_REDIS_VERSION=4.3.1
ARG LIB_AMQP_CPP_VERSION=4.1.4
ARG LIB_SIMPLEAMQPCLIENT_VERSION=2.4.0
ARG LIB_HIREDIS_VERSION=1.0.0
ARG LIB_REDIS_PLUS_PLUS_VERSION=1.2.3

# Install dependencies
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    g++ \
    cmake \
    wget \
    git \
    libmemcached-dev \
    automake \
    bison \
    flex \
    libboost-all-dev \
    libevent-dev \
    libssl-dev \
    libtool \
    make \
    pkg-config \
    librabbitmq-dev \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel

# Install pyyaml
RUN pip3 install PyYAML==5.3.1

# Install mongo-c-driver
RUN cd /tmp \
  && wget -q https://github.com/mongodb/mongo-c-driver/releases/download/${LIB_MONGOC_VERSION}/mongo-c-driver-${LIB_MONGOC_VERSION}.tar.gz \
  && tar -zxf mongo-c-driver-${LIB_MONGOC_VERSION}.tar.gz \
  && cd mongo-c-driver-${LIB_MONGOC_VERSION} \
  && mkdir -p cmake-build \
  && cd cmake-build \
  && cmake -DCMAKE_BUILD_TYPE=Release -DENABLE_TESTS=0 -DENABLE_EXAMPLES=0 .. \
  && make -j$(nproc) \
  && make install \
  && rm -rf \
    /tmp/mongo-c-driver-${LIB_MONGOC_VERSION}.tar.gz \
    /tmp/mongo-c-driver-${LIB_MONGOC_VERSION}

# Install lib-thrift
RUN cd /tmp \
  && wget -qO thrift-${LIB_THRIFT_VERSION}.tar.gz https://github.com/apache/thrift/archive/v${LIB_THRIFT_VERSION}.tar.gz \
  && tar -zxf thrift-${LIB_THRIFT_VERSION}.tar.gz \
  && cd thrift-${LIB_THRIFT_VERSION} \
  && mkdir -p cmake-build \
  && cd cmake-build \
  && cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=0 .. \
  && make -j$(nproc) \
  && make install \
  && rm -rf \
    /tmp/thrift-${LIB_THRIFT_VERSION}.tar.gz \
    /tmp/thrift-${LIB_THRIFT_VERSION}

# Install /nlohmann/json
RUN cd /tmp \
  && wget -qO json-${LIB_JSON_VERSION}.tar.gz https://github.com/nlohmann/json/archive/v${LIB_JSON_VERSION}.tar.gz \
  && tar -zxf json-${LIB_JSON_VERSION}.tar.gz \
  && cd json-${LIB_JSON_VERSION} \
  && mkdir -p cmake-build \
  && cd cmake-build \
  && cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=0 .. \
  && make -j$(nproc) \
  && make install \
  && rm -rf \
    /tmp/json-${LIB_JSON_VERSION}.tar.gz \
    /tmp/json-${LIB_JSON_VERSION}

# Install yaml-cpp
RUN cd /tmp \
  && wget -qO yaml-cpp-${LIB_YAML_VERSION}.tar.gz https://github.com/jbeder/yaml-cpp/archive/yaml-cpp-${LIB_YAML_VERSION}.tar.gz \
  && tar -zxf yaml-cpp-${LIB_YAML_VERSION}.tar.gz \
  && cd yaml-cpp-yaml-cpp-${LIB_YAML_VERSION} \
  && mkdir -p cmake-build \
  && cd cmake-build \
  && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="-fPIC" -DYAML_CPP_BUILD_TESTS=0 .. \
  && make -j$(nproc) \
  && make install \
  && rm -rf \
    /tmp/yaml-cpp-${LIB_YAML_VERSION}.tar.gz \
    /tmp/yaml-cpp-yaml-cpp-${LIB_YAML_VERSION}

# Install opentracing-cpp
RUN cd /tmp \
  && wget -qO opentracing-cpp-${LIB_OPENTRACING_VERSION}.tar.gz https://github.com/opentracing/opentracing-cpp/archive/v${LIB_OPENTRACING_VERSION}.tar.gz \
  && tar -zxf opentracing-cpp-${LIB_OPENTRACING_VERSION}.tar.gz \
  && cd opentracing-cpp-${LIB_OPENTRACING_VERSION} \
  && mkdir -p cmake-build \
  && cd cmake-build \
  && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="-fPIC" -DBUILD_TESTING=0 .. \
  && make -j$(nproc) \
  && make install \
  && rm -rf \
    /tmp/opentracing-cpp-${LIB_OPENTRACING_VERSION}.tar.gz \
    /tmp/opentracing-cpp-${LIB_OPENTRACING_VERSION}

# Install jaeger-client-cpp
RUN cd /tmp \
  && wget -qO jaeger-client-cpp-${LIB_JAEGER_VERSION}.tar.gz https://github.com/jaegertracing/jaeger-client-cpp/archive/v${LIB_JAEGER_VERSION}.tar.gz \
  && tar -zxf jaeger-client-cpp-${LIB_JAEGER_VERSION}.tar.gz \
  && cd jaeger-client-cpp-${LIB_JAEGER_VERSION} \
  && mkdir -p cmake-build \
  && cd cmake-build \
  && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="-fPIC" -DHUNTER_ENABLED=0 -DBUILD_TESTING=0 -DJAEGERTRACING_WITH_YAML_CPP=1 -DJAEGERTRACING_BUILD_EXAMPLES=0 .. \
  && make -j$(nproc) \
  && make install \
  && rm -rf \
    /tmp/jaeger-client-cpp-${LIB_JAEGER_VERSION}.tar.gz \
    /tmp/jaeger-client-cpp-${LIB_JAEGER_VERSION}

# Install jwt
RUN cd /tmp \
  && wget -qO cpp-jwt-${LIB_CPP_JWT_VERSION}.tar.gz https://github.com/arun11299/cpp-jwt/archive/v${LIB_CPP_JWT_VERSION}.tar.gz \
  && tar -zxf cpp-jwt-${LIB_CPP_JWT_VERSION}.tar.gz \
  && cd cpp-jwt-${LIB_CPP_JWT_VERSION} \
  && cp -R include/jwt /usr/local/include \
  # use the dependency in /usr/local/include instead of in jwt/json
  && rm -rf /usr/local/include/jwt/json \
  && sed -i 's/\#include \"jwt\/json\/json.hpp\"/\#include \<nlohmann\/json\.hpp\>/g' /usr/local/include/jwt/jwt.hpp \
  && rm -rf \
    /tmp/cpp-jwt-${LIB_CPP_JWT_VERSION}.tar.gz \
    /tmp/cpp-jwt-${LIB_CPP_JWT_VERSION}

# Install cpp_redis
RUN cd /tmp \
  && git clone https://github.com/cpp-redis/cpp_redis.git \
  && cd cpp_redis \
  && git checkout ${LIB_CPP_REDIS_VERSION} \
  && git submodule init \
  && git submodule update \
  && mkdir cmake-build \
  && cd cmake-build \
  && cmake .. -DCMAKE_BUILD_TYPE=Release \
  && make -j$(nproc) \
  && make install \
  && rm -rf /tmp/cpp_redis

# Install AMQP-CPP
RUN cd /tmp \
  && git clone https://github.com/CopernicaMarketingSoftware/AMQP-CPP.git \
  && cd AMQP-CPP \
  && git checkout v${LIB_AMQP_CPP_VERSION} \
  && mkdir cmake-build \
  && cd cmake-build \
  && cmake .. -DCMAKE_BUILD_TYPE=Release -DAMQP-CPP_BUILD_SHARED=on -DAMQP-CPP_LINUX_TCP=on \
  && make -j$(nproc) \
  && make install \
  && rm -rf /tmp/AMQP-CPP

# Install SimpleAmqpClient
RUN cd /tmp \
  && git clone https://github.com/alanxz/SimpleAmqpClient.git \
  && cd SimpleAmqpClient \
  && git checkout v${LIB_SIMPLEAMQPCLIENT_VERSION} \
  && mkdir cmake-build \
  && cd cmake-build \
  && cmake .. -DCMAKE_BUILD_TYPE=Release \
  && make -j$(nproc) \
  && make install \
  && rm -rf /tmp/SimpleAmqpClient

# Install Hiredis
RUN cd /tmp \
  && git clone https://github.com/redis/hiredis.git \
  && cd hiredis \
  && git checkout v${LIB_HIREDIS_VERSION} \
  && make -j$(nproc) USE_SSL=1 \
  && make USE_SSL=1 install \
  && rm -rf /tmp/hiredis

# Install Redis plus plus
RUN cd /tmp \
  && git clone https://github.com/sewenew/redis-plus-plus.git \
  && cd redis-plus-plus \
  && git checkout ${LIB_REDIS_PLUS_PLUS_VERSION} \
  && sed -i '/Transaction transaction/i\\    ShardsPool* get_shards_pool(){\n        return &_pool;\n    }\n' \
     src/sw/redis++/redis_cluster.h \
  && cmake -DREDIS_PLUS_PLUS_USE_TLS=ON . \
  && make -j$(nproc) \
  && make install \
  && rm -rf /tmp/redis-plus-plus

ENV LD_LIBRARY_PATH /usr/local/lib:${LD_LIBRARY_PATH}
RUN ldconfig

# Build the microservices
COPY ./ /social-network-microservices
RUN cd /social-network-microservices \
  && mkdir -p build \
  && cd build \
  && cmake -DCMAKE_BUILD_TYPE=Debug .. \
  && make -j$(nproc) \
  && make install

FROM ubuntu:16.04

# Copy compiled C++ binaries and dependencies
COPY --from=builder /usr/local/bin/* /usr/local/bin/
COPY --from=builder /usr/local/lib/* /usr/local/lib/

# Install system dependencies
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        openssl \
        ca-certificates \
        libsasl2-2 \
        libmemcached11 \
        libmemcachedutil2 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Set working directory for containerd-based runtimes
WORKDIR /social-network-microservices

# Configure microservices
COPY config /social-network-microservices/config
# If running without DNS:
# RUN sed -i 's/jaeger-agent/11.0.0.2/g' /social-network-microservices/config/jaeger-config.yml
# RUN sed -i 's/"addr": "jaeger-agent"/"addr": "11.0.0.2"/g;s/"addr": "social-graph-redis"/"addr": "11.0.0.3"/g;s/"addr": "home-timeline-redis"/"addr": "11.0.0.4"/g;s/"addr": "user-timeline-redis"/"addr": "11.0.0.5"/g;s/"addr": "social-graph-mongodb"/"addr": "11.0.0.6"/g;s/"addr": "post-storage-mongodb"/"addr": "11.0.0.7"/g;s/"addr": "user-timeline-mongodb"/"addr": "11.0.0.8"/g;s/"addr": "url-shorten-mongodb"/"addr": "11.0.0.9"/g;s/"addr": "user-mongodb"/"addr": "11.0.0.10"/g;s/"addr": "media-mongodb"/"addr": "11.0.0.11"/g;s/"addr": "post-storage-memcached"/"addr": "11.0.0.12"/g;s/"addr": "url-shorten-memcached"/"addr": "11.0.0.13"/g;s/"addr": "user-memcached"/"addr": "11.0.0.14"/g;s/"addr": "media-memcached"/"addr": "11.0.0.15"/g;s/"addr": "social-graph-service"/"addr": "11.0.0.16"/g;s/"addr": "compose-post-service"/"addr": "11.0.0.17"/g;s/"addr": "post-storage-service"/"addr": "11.0.0.18"/g;s/"addr": "user-timeline-service"/"addr": "11.0.0.19"/g;s/"addr": "url-shorten-service"/"addr": "11.0.0.20"/g;s/"addr": "user-service"/"addr": "11.0.0.21"/g;s/"addr": "media-service"/"addr": "11.0.0.22"/g;s/"addr": "text-service"/"addr": "11.0.0.23"/g;s/"addr": "unique-id-service"/"addr": "11.0.0.24"/g;s/"addr": "user-mention-service"/"addr": "11.0.0.25"/g;s/"addr": "home-timeline-service"/"addr": "11.0.0.26"/g;s/"addr": "nginx-thrift"/"addr": "11.0.0.27"/g;s/"addr": "media-frontend"/"addr": "11.0.0.28"/g' /social-network-microservices/config/service-config.json

# systemd setup
COPY services/*.service /etc/systemd/system/
RUN rm /lib/systemd/system/default.target
RUN systemctl disable getty@tty1.service
RUN systemctl mask serial-getty@ttyS0.service
RUN ln -s /lib/systemd/system/multi-user.target /lib/systemd/system/default.target
