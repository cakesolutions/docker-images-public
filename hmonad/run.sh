#!/bin/sh

cd /opt/src &&\
ghc --make /opt/src/hmonad.hs -i -ilib -fforce-recomp -threaded -main-is main -v0 -O3 -o /opt/hmonad -odir /tmp/hmonad -hidir /tmp/hmonad &&\
exec /opt/hmonad
