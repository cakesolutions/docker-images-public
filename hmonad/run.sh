#!/bin/sh

stack ghc --system-ghc -- --make /opt/src/hmonad.hs -i -ilib -fforce-recomp  -main-is main -v0 -o /opt/hmonad -odir /tmp/hmonad -hidir /tmp/hmonad

cd /opt/src
exec /opt/hmonad
