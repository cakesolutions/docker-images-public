#!/bin/bash

# job control to use fg to get back to the main process
set -m

/usr/bin/kinesalite --ssl --shardLimit 100 &

for A in `find /schemas -type f` ; do
    echo "running schema script $A"
    . $A
done

fg
