BINARY_VERSION=$(shell git describe --tags --always --dirty="-dev")
DOCKER_IMAGE=mannkind/speedtest2mqtt
DOCKER_ARCHS=amd64 arm32v6 arm64v8
DOCKER_VERSION=$(BINARY_VERSION)

clean: 
		{ \
		for arch in $(DOCKER_ARCHS); do \
			rm -f Dockerfile.$${arch} ;\
		done ;\
		}

docker: clean
		{ \
		set -e ;\
		for arch in $(DOCKER_ARCHS); do \
		cp Dockerfile.template Dockerfile.$${arch} ;\
		sed -i "" "s|__BASEIMAGE_ARCH__|$${arch}|g" Dockerfile.$${arch} ;\
		done ;\
		}

		$(foreach arch,$(DOCKER_ARCHS),docker build --no-cache --pull -q -f Dockerfile.$(arch) -t $(DOCKER_IMAGE):$(arch)-$(DOCKER_VERSION) . ;)
docker-push:
		$(foreach arch,$(DOCKER_ARCHS),docker push $(DOCKER_IMAGE):$(arch)-$(DOCKER_VERSION);)
		docker manifest create $(DOCKER_IMAGE):$(DOCKER_VERSION) $(DOCKER_IMAGE):amd64-$(DOCKER_VERSION) $(DOCKER_IMAGE):arm32v6-$(DOCKER_VERSION) $(DOCKER_IMAGE):arm64v8-$(DOCKER_VERSION)
		docker manifest annotate $(DOCKER_IMAGE):$(DOCKER_VERSION) $(DOCKER_IMAGE):arm32v6-$(DOCKER_VERSION) --os linux --arch arm --variant v6
		docker manifest annotate $(DOCKER_IMAGE):$(DOCKER_VERSION) $(DOCKER_IMAGE):arm64v8-$(DOCKER_VERSION) --os linux --arch arm64 --variant v8
		docker manifest push --purge $(DOCKER_IMAGE):$(DOCKER_VERSION)
