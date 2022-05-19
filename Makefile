
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

shell_with_ports:
	docker run -it $(PORTS) $(VOLUMES) $(WORKDIR) $(PACKAGE_NAME) bash

server:
	docker run --rm -it --name shaka $(VOLUMES) $(WORKDIR) $(PORTS) $(ENVS) $(PACKAGE_NAME) bash -c "yarn install && foreman start -f Procfile.dev"

js_testing: image selenium_running ## Runs js browser tests
	$(call yarn_test, -it -p 127.0.0.1:9876:9876 -e HEADLESS=true -e NODE_ENV=test) yarn watch:test:browser
