FROM debian:stretch
ENV LANG C.UTF-8

# compiles an hmonad.hs, mounted in /opt/src, and then runs the
# binary from that directory. Allows for user-defined http servers.

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl ghc zlib1g-dev cabal-install && \
    apt-get autoremove -qq && \
    apt-get clean

RUN cabal update && cabal install \
  scotty \
  scotty-tls \
  network-uri \
  hxt \
  shakespeare \
  http-client \
  http-client-tls \
  http-types \
  uuid \
  bytestring \
  lens \
  aeson \
  containers &&\
  rm -rf /root/.cabal/packages /root/.cabal/logs /tmp/*

COPY run.sh /opt/
RUN chmod +x /opt/run.sh

EXPOSE 80
CMD ["/opt/run.sh"]
