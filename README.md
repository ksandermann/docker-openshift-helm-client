# docker-openshift-helm-client
Small Docker client for deploying with helm to openshift. Containing kubectl, os cli and helm client

# How to run 

## Build and Run locally

docker build -t openshift-helm-client:local .

docker run -ti --rm openshift-helm-client:local bash

## Run from DockerHub

docker run -ti --rm ksandermann/openshift-helm-client:latest bash
