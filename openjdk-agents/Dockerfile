FROM openjdk:8-jre

# OpenJDK with the YourKit allowing apps to be profiled, e.g.
#
# -agentpath:/opt/yourkit/bin/linux-x86-64/libyjpagent.so=quiet,port=10001,dir=/tmp
#
# Attaching to and analysing the running JVM requires a proprietary
# license: https://www.yourkit.com/purchase/
#
# Also has the newrelic agent

ENV YOURKIT_AGENT /opt/yourkit/bin/linux-x86-64/libyjpagent.so

RUN\
  wget -O /tmp/yourkit.zip https://www.yourkit.com/download/YourKit-JavaProfiler-2017.02-b75.zip &&\
  unzip /tmp/yourkit.zip -d /opt &&\
  mv /opt/YourKit-JavaProfiler-2017.02 /opt/yourkit &&\
  rm /tmp/yourkit.zip

RUN\
  wget -O /tmp/newrelic.zip https://download.newrelic.com/newrelic/java-agent/newrelic-agent/4.2.0/newrelic-java-4.2.0.zip &&\
  unzip /tmp/newrelic.zip -d /opt &&\
  rm /tmp/newrelic.zip &&\
  mkdir -p /opt/newrelic/logs /opt/newrelic/extensions

COPY Akka-Streams_2.12.jar /opt/newrelic/extensions/
COPY AWS-Kinesis-Client.jar /opt/newrelic/extensions/
COPY Kinesis-Producer.jar /opt/newrelic/extensions/
COPY Redisson_3.5.jar /opt/newrelic/extensions/
