# hmonad

Allows compiling / running user-defined Haskell http applications with
a very fast startup.

See the example in the `example` directory. Start it with

```
docker-compose -f example/HelloWorld/hello.yml up
```

and direct your browser at http://localhost:1337

We are aware that we could use `stack script` and get access to
arbitrary dependencies, but it is critical that there is no network
lookup to:

1. increase stability in all environments
1. startup fast

if you need access to a library that is not available, you need to
fork this image, add your dep to the `Dockerfile`, and publish to
your own container registry.

To build your own local image locally, run something like

```
docker build -t cakesolutions/hmonad:latest .
```
## Dev tips

If you install [Stack](https://docs.haskellstack.org/en/stable/README/#how-to-install),
you can use `stack gchi --ghc-options hmonad.hs` or by calling `stack ghci` and
then (in the repl): `:load hmonad.hs`. If you haven't done so yet, you will
need to install Scotty via `stack install scotty` (and possibly other dependencies)

With this setup you can quickly compile the hmonad.hs file and check for errors.

`stack` will produce a `.stack-work` directory, you may need to add it to
`.gitignore`.
