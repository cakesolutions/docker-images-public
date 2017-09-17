FROM buildpack-deps:stretch-curl
# same base as openjdk:8-jre, so reduces docker footprint

EXPOSE 4567

ENV LANG C.UTF-8

RUN apt-get update -qq && \
    apt-get install -y python unzip && \
    wget -O awscli.zip https://s3.amazonaws.com/aws-cli/awscli-bundle.zip && \
    unzip awscli.zip && \
    rm -f awscli.zip && \
    ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && \
    mkdir /schemas && \
    apt-get autoremove -qq && \
    apt-get clean

RUN apt-get update -qq && \
    apt-get install -y apt-utils make g++ && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get install -y nodejs && \
    npm install kinesalite --global && \
    mkdir /var/lib/kinesalite && \
    apt-get remove -qq make g++ && \
    apt-get autoremove -qq && \
    apt-get clean

COPY run.sh /opt/

# aws-cli need default region/creds, even if we only talk to local
# services. Yes, it really is that dumb.
COPY .aws /root/.aws

# Add streams like http://docs.aws.amazon.com/cli/latest/reference/kinesis/create-stream.html
# aws kinesis create-stream --stream-name foo --shard-count 3 --endpoint-url https://localhost:4567 --no-verify-ssl

CMD ["/opt/run.sh"]
