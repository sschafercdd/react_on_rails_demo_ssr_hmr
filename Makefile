
WORKDIR=--workdir /tmp/src
VOLUMES=--volume $(PWD):/tmp/src:delegated
PACKAGE_NAME=shaka
PORT=127.0.0.1:3000
PORTS=-p $(PORT):3000 -p 127.0.0.1:3035:3035
ENVS=

image:
	docker build -t $(PACKAGE_NAME) -f Dockerfile .

shell:
	docker run -it $(VOLUMES) $(WORKDIR) $(PACKAGE_NAME) bash

server:
	docker run --rm -it --name shaka $(VOLUMES) $(WORKDIR) $(PORTS) $(ENVS) $(PACKAGE_NAME) bash -c "yarn install && foreman start -f Procfile.dev"
