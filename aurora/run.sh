#!/bin/bash

# job control to use fg to get back to the java process
set -m

/opt/mysql/server-5.6/bin/mysqld_safe &

# fails with "mysqld not found" ... not sure why.
#until `/opt/mysql/server-5.6/bin/mysqladmin ping -h localhost`
#do
#    echo "waiting for DB"
#    sleep 1
#done

for A in /schemas/*.sql ; do
    echo "running schema script $A"
    until `/opt/mysql/server-5.6/bin/mysql --user=root -P3306 < $A`
    do
        echo "trying again"
        sleep 1
    done
done

touch /tmp/mysqlready.lock

fg

