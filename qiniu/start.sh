#!/bin/bash

set -e

ROOT=$(unset CDPATH && cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd $ROOT

RSYNC_OPTS="--daemon --config rsyncd.conf --no-detach"

echo "ROOT: $ROOT"
echo "CMD: ./rsync $RSYNC_OPTS"

PASSWORD=493151a2-3f48-4ab2-8a83-86e990008b4d

echo "qcos:$PASSWORD" > rsyncd.secrets
chmod 600 rsyncd.secrets

# for clients
echo "$PASSWORD" > /etc/volume.secrets
chmod 600 /etc/volume.secrets
ln -sf $(pwd)/rsync /usr/local/bin/rsync

# clear pid files before start
# FIX "failed to create pid file rsyncd.pid: File exists" error.
rm *.pid

exec ./rsync $RSYNC_OPTS
