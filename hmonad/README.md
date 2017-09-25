# hmonad

Allows compiling / running user-defined Haskell http applications with
a very fast startup.

See the example in the `example` directory. Start it with

```
docker-compose -f example/hello.yml up
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
