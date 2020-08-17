.PHONY: default build latest push push-latest clean run

IMAGE_NAME = leslykqi/yii2
CONTAINER_NAME = yii2
IMAGE_TAG = 1.0.0
IMAGE_BASE = centos/httpd
FULL_IMAGE_NAME = $(IMAGE_NAME):$(IMAGE_TAG)

default: build

build:
	docker pull $(IMAGE_BASE)
	docker build -t $(FULL_IMAGE_NAME) --no-cache .

latest:
	docker tag $(FULL_IMAGE_NAME) $(IMAGE_NAME):latest

push:
	docker push $(FULL_IMAGE_NAME)

push-latest:
	docker push $(IMAGE_NAME):latest

clean:
	docker rmi $(IMAGE_NAME):latest || true
	docker rmi $(FULL_IMAGE_NAME) || true
	docker rmi $(IMAGE_BASE)

run:
	docker run --rm -d --name $(CONTAINER_NAME) -p 80:80 -p 2222:22  $(FULL_IMAGE_NAME)