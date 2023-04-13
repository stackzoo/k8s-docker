# LOCAL K8S DEV ENVIRONMENT

A simple local kubernetes dev environment based on <a href="https://kind.sigs.k8s.io">KinD</a> or <a href="https://minikube.sigs.k8s.io/docs/">Minikube</a>.
<br/>
You can use this for local development, testing, experimenting and even studying for the officials *CNCF* certifications.
<br/>
**NOTE**: this only create the cluster and install metrics server on it, for more configurations and addons please read the official docs.

## Requirements
- `docker`
- `kind`
- `minikube`
- `kubectl`
- `helm`
- `make`

## Instructions
This repo contains a *Makefile*, you can inspect the make targets with the following command:
```sh
❯ make help

Usage:
  make <target>
  help             Display this help.
  kind-up          Spin up a dev cluster with KinD
  kind-down        Delete the KinD dev cluster
  mini-up      Spin up a dev cluster with Minikube
  mini-dashboard  Enable minikube web dashboard
  mini-down    Delete the Minikube dev cluster
```
<br/>

To spin up your local dev cluster with *KinD*:
```sh
❯ make kind-up

Creating cluster "dev-cluster" ...
 ✓ Ensuring node image (kindest/node:v1.26.3) 🖼
 ✓ Preparing nodes 📦 📦 📦 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾
 ✓ Joining worker nodes 🚜
Set kubectl context to "kind-dev-cluster"
You can now use your cluster with:

kubectl cluster-info --context kind-dev-cluster

Not sure what to do next? 😅  Check out https://kind.sigs.k8s.io/docs/user/quick-start/
"metrics-server" already exists with the same configuration, skipping
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "metrics-server" chart repository
...Successfully got an update from the "gatekeeper" chart repository
...Successfully got an update from the "neuvector" chart repository
...Successfully got an update from the "kong" chart repository
...Successfully got an update from the "hashicorp" chart repository
...Successfully got an update from the "falcosecurity" chart repository
...Successfully got an update from the "elastic" chart repository
...Successfully got an update from the "keptn" chart repository
...Successfully got an update from the "crossplane-stable" chart repository
...Successfully got an update from the "banzaicloud-stable" chart repository
Update Complete. ⎈Happy Helming!⎈
Release "metrics-server" does not exist. Installing it now.
NAME: metrics-server
LAST DEPLOYED: Thu Apr 13 10:19:10 2023
NAMESPACE: kube-system
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
***********************************************************************
* Metrics Server                                                      *
***********************************************************************
  Chart version: 3.10.0
  App version:   0.6.3
  Image tag:     registry.k8s.io/metrics-server/metrics-server:v0.6.3
***********************************************************************
<waiting for metrics server to be up and running>
deployment.apps/metrics-server condition met
<test metrics retrieval>
NAME                        CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
dev-cluster-control-plane   167m         4%     561Mi           7%
dev-cluster-worker          26m          0%     106Mi           1%
dev-cluster-worker2         125m         3%     132Mi           1%
dev-cluster-worker3         24m          0%     108Mi           1%
```

To delete the *KinD* cluster:
```sh
❯ make kind-down

Deleting cluster "dev-cluster" ...
Deleted nodes: ["dev-cluster-worker2" "dev-cluster-worker" "dev-cluster-worker3" "dev-cluster-control-plane"]
```
