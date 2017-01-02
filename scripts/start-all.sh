#!/usr/bin/env bash

dir=$(dirname $0)
source $dir/common.sh

if [ $# -gt 0 ]; then
   $dir/zk.sh $1
   $dir/broker.sh $1
else
    echo "Usage: "$(basename $0)" <zk and broker IDs>"
fi
