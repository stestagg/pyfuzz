FROM ubuntu:latest

RUN apt update && apt upgrade -y
RUN apt-get install -y build-essential
RUN apt-get install -y git pkg-config

WORKDIR /root

RUN git clone https://github.com/google/AFL.git
RUN git clone https://github.com/python/cpython

WORKDIR /root/AFL
RUN make
WORKDIR /root

RUN apt-get install -y gdb lcov pkg-config \
      libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
      libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
      lzma lzma-dev tk-dev uuid-dev zlib1g-dev

COPY fuzzland /root/fuzzland/

ENV CC /root/AFL/afl-gcc
ENV CXX /root/AFL/afl-g++

ENTRYPOINT /root/fuzzland/build.sh