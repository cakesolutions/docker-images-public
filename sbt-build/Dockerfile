FROM openjdk:8u131-jdk-slim
label maintainer="devops@cakesolutions.net"

ARG SBT_VERSION=1.1.4
ARG DOCKER_VERSION=17.03.1
ARG DOCKER_COMPOSE_VERSION=1.15.0
ARG EXTRA_PKGS='apt-transport-https gnupg2 ca-certificates software-properties-common openssl bash curl wget protobuf-compiler libprotobuf-dev'

ENV DOCKER_VERSION ${DOCKER_VERSION}
ENV SBT_VERSION ${SBT_VERSION} 
ENV PATH /sbt/bin:$PATH

# core
RUN apt-get update && \
    apt-get install -y ${EXTRA_PKGS} && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update -y && \
    apt-get install -y docker-ce=${DOCKER_VERSION}~ce-0~debian-stretch && \
    apt-get install sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" && \
    chmod +x /usr/local/bin/docker-compose && \
    cd / && \
    wget -qO - --no-check-certificate "https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz" | tar xz

CMD [ "sbt", "check", "compile" ]
