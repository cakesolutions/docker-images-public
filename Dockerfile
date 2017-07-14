FROM openjdk:8-jre

# based on https://github.com/deangiberson/docker_aws_dynamodb_local
# but will create a (user provided) schema on the DB on startup

EXPOSE 8000

RUN wget -O /tmp/dynamodb.tar.gz https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz && \
    tar xfz /tmp/dynamodb.tar.gz -C /opt && \
    rm -f /tmp/dynamodb.tar.gz && \
    mkdir /var/dynamodb_local

RUN wget -O awscli.zip https://s3.amazonaws.com/aws-cli/awscli-bundle.zip && \
    unzip awscli.zip && \
    rm -f awscli.zip && \
    apt-get update -qq &&\
    apt-get install -y python &&\
    ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && \
    mkdir /schemas

COPY run.sh /opt/

# aws-cli need default region/creds, even if we only talk to local
# services. Yes, it really is that dumb.
COPY .aws /root/.aws

# aws dynamodb create-table \
#     --table-name Music \
#     --attribute-definitions \
#         AttributeName=Artist,AttributeType=S \
#         AttributeName=SongTitle,AttributeType=S \
#     --key-schema AttributeName=Artist,KeyType=HASH AttributeName=SongTitle,KeyType=RANGE \
#     --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
#     --endpoint-url http://localhost:8000 \
# aws dynamodb list-tables --endpoint-url http://localhost:8000

ENTRYPOINT ["/opt/run.sh"]
