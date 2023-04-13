SHELL := /bin/bash
KIND=$(shell which kind)
MINIKUBE=$(shell which minikube)
KUBECTL=$(shell which kubectl)
# KUBECONFIG ?= $(HOME)/.kube/config

.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

## KIND
kind-up: ## Spin up a dev cluster with KinD
	@$(KIND) create cluster --config ./cluster-config/kind-config.yaml
	@$(SHELL) ./cluster-config/metrics.sh
	@echo  "<waiting for metrics server to be up and running>"
	@$(KUBECTL) wait deployment metrics-server -n kube-system --for condition=Available=True --timeout=100s
	@echo  "<test metrics retrieval>"
	@$(KUBECTL) top nodes

kind-down: ## Delete the KinD dev cluster
	@$(KIND) delete cluster --name dev-cluster

## MINIKUBE
mini-up: ## Spin up a dev cluster with Minikube
	@$(MINIKUBE) start --nodes=3
	@$(SHELL) ./cluster-config/metrics.sh
	@echo  "<waiting for metrics server to be up and running>"
	@$(KUBECTL) wait deployment metrics-server -n kube-system --for condition=Available=True --timeout=100s

mini-dashboard: ## Enable minikube web dashboard
	@$(MINIKUBE) dashboard --url

mini-down: ## Delete the Minikube dev cluster
	@$(MINIKUBE) stop
	@$(MINIKUBE) delete --all