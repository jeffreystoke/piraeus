PROJECT ?= piraeus-server
REGISTRY ?= piraeusdatastore
TAG ?= latest

help:
	@echo "Useful targets: 'update', 'upload'"

all: update upload

.PHONY: update
update:
	docker build -t $(PROJECT):$(TAG) .
	docker tag $(PROJECT):$(TAG) $(PROJECT):latest

.PHONY: upload
upload:
	for r in $(REGISTRY); do \
		docker tag $(PROJECT):$(TAG) $$r/$(PROJECT):$(TAG) ; \
		docker tag $(PROJECT):$(TAG) $$r/$(PROJECT):latest ; \
		docker push $$r/$(PROJECT):$(TAG) ; \
		docker push $$r/$(PROJECT):latest ; \
	done
