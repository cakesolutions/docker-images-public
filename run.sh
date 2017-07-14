#!/bin/sh

/usr/bin/java -jar /opt/DynamoDBLocal.jar -dbPath /var/dynamodb_local -port 8000 &

for A in `find /schemas -type f` ; do
    echo "running schema script $A"
    . $A
done
