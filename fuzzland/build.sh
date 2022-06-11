#!/bin/bash

set -xeu

mkdir /root/prefix

(
    cd /root/cpython
    git pull
    ./configure --enable-optimizations --prefix=/root/prefix
    env AFL_IGNORE_PROBLEMS=1 make -j4
    make install
)

