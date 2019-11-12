
FROM ubuntu:latest AS builder

MAINTAINER Adam Bryant <adam.w.bryant@outlook.com>

RUN apt-get update
RUN apt-get install -y python2.7 python2.7-dev libboost1.65-dev cmake g++ git

RUN git clone https://github.com/libuv/libuv /opt/libuv
RUN mkdir /opt/libuv/build
WORKDIR /opt/libuv/build
RUN cmake ..
RUN make -j4 install

RUN git clone https://github.com/jbeder/yaml-cpp /opt/yaml-cpp
RUN mkdir /opt/yaml-cpp/build
WORKDIR /opt/yaml-cpp/build
RUN cmake ..
RUN make -j4 install

RUN git clone https://github.com/SOCI/soci.git /opt/soci
RUN mkdir /opt/soci/build

RUN apt-get install -y sqlite3 libsqlite3-dev
WORKDIR /opt/soci/build
RUN cmake ..
RUN make -j4 install

ADD astron /opt/astron-source
WORKDIR /opt/astron-source/build
RUN cmake .. -DCMAKE_BUILD_TYPE=Debug
RUN make  -j4

RUN mkdir -p /opt/astron
RUN cp astrond /opt/astron/astrond

WORKDIR /opt/astron

ENTRYPOINT ["/opt/astron/astrond"]
