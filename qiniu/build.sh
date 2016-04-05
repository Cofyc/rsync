#!/bin/bash

set -e

apt-get install -y yodl

make reconfigure
./configure
make
