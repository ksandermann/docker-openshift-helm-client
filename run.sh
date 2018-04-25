#!/usr/bin/env bash

docker build -t openshift_helm_client:local .

docker run -ti --rm -v $(pwd):/project -v ~/.kube:/root/.kube -v $HOME/.ssh:/root/.ssh openshift_helm_client:local bash