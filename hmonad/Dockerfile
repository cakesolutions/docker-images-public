FROM haskell:8.2

# compiles an hmonad.hs, mounted in /opt/src, and then runs the
# binary from that directory. Allows for user-defined http servers.

RUN apt-get update -qq && \
    apt-get install -y make xz-utils curl && \
    apt-get autoremove -qq && \
    apt-get clean

COPY stack.yaml /root/.stack/global-project/stack.yaml

# Upgrade is necessary as the bundled version has a bug preventing it handling `--` within flags (1.6.1+ required)
# See: https://github.com/commercialhaskell/stack/issues/3345
RUN stack upgrade
RUN stack setup --system-ghc

RUN stack install scotty scotty-tls network-uri hxt shakespeare \
                  http-client http-client-tls http-types uuid bytestring \
                  base bytestring text wai wai-extra stm mtl unix-time \
                  cassava vector containers http-types extra

COPY run.sh /opt/

RUN chmod +x /opt/run.sh

EXPOSE 80
CMD ["/opt/run.sh"]
