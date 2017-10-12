#!/bin/bash

# job control to use fg to get back to the java process
set -m

/opt/mysql/server-5.6/bin/mysqld_safe &

for A in `find /schemas -type f` ; do
    echo "running schema script $A"
    until `. $A`
    do
      sleep 1
      echo "Retrying script $A"
    done
done

fg

