CURRENT_DIR := $(shell pwd)
AVD_CONTAINER_IMAGE := ghcr.io/ankudinov/base-for-647/base:latest

.PHONY: help
help: ## Display help message
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: run
run: ## Run AVD container
	docker run --rm -it \
			--user vscode \
			--network host \
			--pid="host" \
			-w $(CURRENT_DIR) \
			-v $(CURRENT_DIR):$(CURRENT_DIR) \
			-e AVD_GIT_USER="$(shell git config --get user.name)" \
			-e AVD_GIT_EMAIL="$(shell git config --get user.email)" \
			$(AVD_CONTAINER_IMAGE) || true ;
