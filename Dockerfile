
FROM ubuntu:latest

MAINTAINER Adam Bryant <adam.w.bryant@outlook.com>

RUN apt-get update
RUN apt-get install -y python2.7 python2.7-dev libboost1.58-dev cmake g++ git

RUN git clone https://github.com/libuv/libuv /opt/libuv
RUN mkdir /opt/libuv/build
WORKDIR /opt/libuv/build
RUN cmake ..
RUN make install

RUN git clone https://github.com/jbeder/yaml-cpp /opt/yaml-cpp
RUN mkdir /opt/yaml-cpp/build
WORKDIR /opt/yaml-cpp/build
RUN cmake ..
RUN make install

RUN git clone https://github.com/SOCI/soci.git /opt/soci
RUN mkdir /opt/soci/build

RUN apt-get install -y sqlite3 libsqlite3-dev
WORKDIR /opt/soci/build
RUN cmake ..
RUN make install

ADD astron /opt/astron-source
WORKDIR /opt/astron-source/build
RUN cmake ..
RUN make 
# make install is currently broken
RUN cp astrond /usr/local/bin/astrond
