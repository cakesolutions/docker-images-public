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
  wget -O /tmp/yourkit.zip https://www.yourkit.com/download/YourKit-JavaProfiler-2017.02-b66.zip &&\
  unzip /tmp/yourkit.zip -d /opt &&\
  mv /opt/YourKit-JavaProfiler-2017.02 /opt/yourkit &&\
  rm /tmp/yourkit.zip

RUN\
  wget -O /tmp/newrelic.zip https://download.newrelic.com/newrelic/java-agent/newrelic-agent/3.43.0/newrelic-java-3.43.0.zip &&\
  unzip /tmp/newrelic.zip -d /opt &&\
  rm /tmp/newrelic.zip &&\
  mkdir -p /opt/newrelic/logs /opt/newrelic/extensions

COPY Play-2.6.jar /opt/newrelic/extensions/
COPY Play-2.6-Java.jar /opt/newrelic/extensions/
COPY Akka-Streams_2.12.jar /opt/newrelic/extensions/
COPY Play-2.6-WS.jar /opt/newrelic/extensions/
COPY Play-2.6-WS-Java.jar /opt/newrelic/extensions/
