FROM ubuntu:16.04 as builder
MAINTAINER Kevin Sandermann <kevin.sandermann@gmail.com>

ARG OC_CLI_SOURCE="https://github.com/openshift/origin/releases/download/v3.6.1/openshift-origin-client-tools-v3.6.1-008f2d5-linux-64bit.tar.gz"
ARG HELM_CLIENT_SOURCE="https://storage.googleapis.com/kubernetes-helm/helm-v2.6.1-linux-amd64.tar.gz"
ARG KUBECTL_SOURCE="https://storage.googleapis.com/kubernetes-release/release/v1.10.0/bin/linux/amd64/kubectl"

ENV WORKDIR="~/download"
WORKDIR $WORKDIR

RUN apt-get update && apt-get install -y \
    curl

RUN curl -LO $KUBECTL_SOURCE

RUN touch oc_cli.tar.gz && \
    curl -SsL --retry 5 -o oc_cli.tar.gz  $OC_CLI_SOURCE && \
    tar xf oc_cli.tar.gz

RUN curl -SsL --retry 5 $HELM_CLIENT_SOURCE | tar xz


FROM phusion/baseimage:0.10.0
MAINTAINER Kevin Sandermann <kevin.sandermann@gmail.com>

COPY --from=builder "~/download/linux-amd64/helm" "/usr/local/bin/helm"
RUN chmod +x "/usr/local/bin/helm"

COPY --from=builder "~/download/kubectl" "/usr/local/bin/kubectl"
RUN chmod +x "/usr/local/bin/kubectl"

COPY --from=builder "~/download/openshift-origin-client-tools-v3.6.1-008f2d5-linux-64bit/oc" "/usr/local/bin/oc"
RUN chmod +x "/usr/local/bin/oc"

RUN helm init --client-only