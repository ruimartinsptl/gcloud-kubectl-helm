FROM alpine:latest

ARG CLOUD_SDK_VERSION="229.0.0"
ENV CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION

ARG KUBECTL_VERSION="1.14.2"
ENV KUBECTL_VERSION=$KUBECTL_VERSION

ARG HELM_VERSION="2.14.0"
ENV HELM_VERSION=$HELM_VERSION

WORKDIR /root

RUN apk update && apk add --no-cache --virtual .build-deps \
    ca-certificates \
    curl \
    tar \
    bash \
    openssl \
    python \
    git && \
    curl -OL https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzfv google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    ln -s /root/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud && \
    ln -s /lib /lib64 && \
    echo "INFO: You installed gcloud version '$CLOUD_SDK_VERSION' the last release is '$(curl -s https://raw.githubusercontent.com/google-cloud-sdk/google-cloud-sdk/master/VERSION)'." && \
    curl -OL https://storage.googleapis.com/kubernetes-release/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    echo "You installed kubectl version 'v$KUBECTL_VERSION' the last release is '$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)'." && \
    curl -OL https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    tar xzf helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    rm helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    mv linux-amd64/tiller /usr/local/bin/tiller && \
    chmod +x /usr/local/bin/helm && \
    chmod +x /usr/local/bin/tiller && \
    echo "You installed helm version '$HELM_VERSION' the last release is '<TO DO>'."

CMD ["/bin/bash"]
