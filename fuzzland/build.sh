#!/bin/bash

set -x

(
    cd /root/cpython
    git pull    
    ./configure --enable-optimizations
    make
)