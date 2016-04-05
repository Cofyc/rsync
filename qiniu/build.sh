#!/bin/bash

set -e

make reconfigure
./configure
make rsync
