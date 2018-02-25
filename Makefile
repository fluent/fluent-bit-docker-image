DOCKER_IMAGE_NAME=fluent/fluent-bit
DOCKER_IMAGE_VERSION=0.12.9

default: steps

steps:
	if [ "$(TARGET_ARCHITECTURE)" = "arm32v7" ] || [ $(TARGET_ARCHITECTURE) = "" ]; then DOCKER_IMAGE_FILENAME="Dockerfile.arm32v7" DOCKER_IMAGE_TAGNAME=$(DOCKER_IMAGE_NAME):arm32v7-$(DOCKER_IMAGE_VERSION) make build; fi
	if [ "$(TARGET_ARCHITECTURE)" = "x86_64" ] || [ $(TARGET_ARCHITECTURE) = "" ]; then DOCKER_IMAGE_FILENAME="Dockerfile.x86_64" DOCKER_IMAGE_TAGNAME=$(DOCKER_IMAGE_NAME):x86_64-$(DOCKER_IMAGE_VERSION) make build; fi

build:
	docker build --build-arg FLB_VERSION=$(DOCKER_IMAGE_VERSION) -t $(DOCKER_IMAGE_TAGNAME) -f image-platforms/$(DOCKER_IMAGE_FILENAME) .

push:
	if [ ! "$(TARGET_ARCHITECTURE)" = "" ]; then \
		docker push $(DOCKER_IMAGE_NAME):$(TARGET_ARCHITECTURE)-$(DOCKER_IMAGE_VERSION); \
		docker push $(DOCKER_IMAGE_NAME):$(TARGET_ARCHITECTURE)-latest \
	else \
		echo "Please pass TARGET_ARCHITECTURE, see README.md."; \
	fi

.PHONY: steps build push
.SILENT: