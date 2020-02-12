#!/bin/bash

set -e

SQ_CACHE_LOCK=/var/cache/squid/cache.lck
if [ ! -f ${SQ_CACHE_LOCK} ]; then
    squid -z
    sleep 5
    touch ${SQ_CACHE_LOCK}
fi

exec squid -NYCd 1