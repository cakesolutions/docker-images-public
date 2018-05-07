# sbt-build:0.13.15-0.0.1

## The Docker image used by Jenkins agents to build SBT projects.

An image with:
- OpenJDK 8u131
- SBT 0.13.15
- Docker 1.11.2-r1

## Contributing

```
# Make changes to Dockerfile ...
# Build the Image
docker build -t 950377457506.dkr.ecr.us-east-1.amazonaws.com/adtech/sbt-build:0.13.15 .
# Run the Image locally
docker run -t -i 950377457506.dkr.ecr.us-east-1.amazonaws.com/adtech/sbt-build:0.13.15 /bin/sh
# Test changes ...
```

## Pushing

If a new version of the sbt build Image required, build and test as above and then Publish to the AdTech ECR.

You will need to login to ECR first, profile configuration needs to be setup on your machine first.

```
eval $(aws --profile mlbam-coreeng-adtech --region us-east-1 ecr get-login)
```

```
docker push 950377457506.dkr.ecr.us-east-1.amazonaws.com/adtech/sbt-build:0.13.15
```

## Usage

Open up an interactive terminal on the container:
```
docker run -t -i 950377457506.dkr.ecr.us-east-1.amazonaws.com/adtech/sbt-build:0.13.15 /bin/sh
```

Find out about sbt (and make use of the hosts ivy2 cache):
```
docker run --rm \
  --volume ~/.ivy2:/root/.ivy2 \
  --volume ~/.sbt:/root/.sbt \
  --volume ~/.coursier:/root/.coursier \
  950377457506.dkr.ecr.us-east-1.amazonaws.com/adtech/sbt-build:0.13.13 \
  sbt about
```

Compile a project in the hosts pwd using sbt:
```
docker run --rm \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume ~/.ivy2:/root/.ivy2 \
  --volume ~/.sbt:/root/.sbt \
  --volume ~/.coursier:/root/.coursier \
  --volume $(pwd):/workspace \
  --workdir /workspace \
  950377457506.dkr.ecr.us-east-1.amazonaws.com/adtech/sbt-build:0.13.15 \
  sbt compile
```

Publish a docker image (via the hosts docker!):
```
docker run --rm \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume ~/.ivy2:/root/.ivy2 \
  --volume ~/.sbt:/root/.sbt \
  --volume ~/.coursier:/root/.coursier \
  --volume $(pwd):/workspace \
  --workdir /workspace \
  950377457506.dkr.ecr.us-east-1.amazonaws.com/adtech/sbt-build:0.13.15 \
  sbt docker:publish
```

### Wait! Docker-in-docker?
No, not really. Docker in docker would require `docker run --privileged ...`.

We install and use the binaries e.g. `/bin/docker`, but we don't run the service.

Instead we map `/var/run/docker.sock` from the host to the container using `--volume`.
