FROM haskell:8.2

# compiles an hmonad.hs, mounted in /opt/src, and then runs the
# binary from that directory. Allows for user-defined http servers.

RUN apt-get update -qq && \
    apt-get install -y make xz-utils && \
    apt-get autoremove -qq && \
    apt-get clean

COPY stack.yaml /root/.stack/global-project/stack.yaml

RUN stack setup --system-ghc && \
    stack install scotty

RUN stack install shakespeare

COPY run.sh /opt/

EXPOSE 80
CMD ["/opt/run.sh"]
