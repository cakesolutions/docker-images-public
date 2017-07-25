#!/bin/bash

# job control to use fg to get back to the java process
set -m

/usr/bin/java -Djava.library.path=/opt/DynamoDBLocal_lib -jar /opt/DynamoDBLocal.jar -dbPath /var/dynamodb_local -port 8000 -sharedDb &

for A in `find /schemas -type f` ; do
    echo "running schema script $A"
    . $A
done

fg
