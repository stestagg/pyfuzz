FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt upgrade -y
RUN apt-get install -y build-essential clang llvm git pkg-config
RUN apt-get install -y git pkg-config
RUN apt-get install -y lcov \
      libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
      libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
      lzma lzma-dev tk-dev uuid-dev zlib1g-dev

WORKDIR /root

RUN git clone https://github.com/AFLplusplus/AFLplusplus.git
RUN git clone https://github.com/python/cpython

WORKDIR /root/AFLplusplus
RUN make
WORKDIR /root

COPY fuzzland /root/fuzzland/

ENV CC /root/AFLplusplus/afl-clang-fast
ENV CXX /root/AFLplusplus/afl-clang-fast++
ENV AFL_MAP_SIZE 160000
ENTRYPOINT /root/fuzzland/build.sh