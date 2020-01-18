FROM bitnami/minideb:stretch
LABEL maintainer="amadeusz.starzykiewicz@u2i.com"

ARG kubectl_version=1.12.10
ARG helm_version=3.0.2

# Install required system packages and dependencies
RUN install_packages ca-certificates wget

# Install kubectl
RUN wget -nc -P /tmp/bitnami/pkg/cache/ https://downloads.bitnami.com/files/stacksmith/kubectl-${kubectl_version}-1-linux-amd64-debian-9.tar.gz && \
    echo "57612b8cc7b8c93a708cd5f5314d824a153db26764aa7cbe80230ed6b32e7db0  /tmp/bitnami/pkg/cache/kubectl-${kubectl_version}-1-linux-amd64-debian-9.tar.gz" | sha256sum -c - && \
    tar -zxf /tmp/bitnami/pkg/cache/kubectl-${kubectl_version}-1-linux-amd64-debian-9.tar.gz -P --transform 's|^[^/]*/files|/opt/bitnami|' --wildcards '*/files' && \
    rm -rf /tmp/bitnami/pkg/cache/kubectl-${kubectl_version}-1-linux-amd64-debian-9.tar.gz
RUN chmod +x /opt/bitnami/kubectl/bin/kubectl

# Install helm
RUN mkdir -p /opt/bitnami/helm
RUN wget -nc -P /tmp/bitnami/pkg/cache/ https://get.helm.sh/helm-v${helm_version}-linux-amd64.tar.gz && \
    echo "c6b7aa7e4ffc66e8abb4be328f71d48c643cb8f398d95c74d075cfb348710e1d  /tmp/bitnami/pkg/cache/helm-v${helm_version}-linux-amd64.tar.gz" | sha256sum -c - && \
    tar -xzf /tmp/bitnami/pkg/cache/helm-v${helm_version}-linux-amd64.tar.gz --strip-components=1 -C /opt/bitnami/helm linux-amd64/helm && \
    rm -rf /tmp/bitnami/pkg/cache/helm-v${helm_version}-linux-amd64.tar.gz
RUN chmod +x /opt/bitnami/helm/helm

# Set required variables
ENV KUBECONFIG=/root/kubeconfig.yaml
ENV GOOGLE_APPLICATION_CREDENTIALS=/root/google-key.json

ENV BITNAMI_APP_NAME="helm" \
    BITNAMI_IMAGE_VERSION="3.0.2-debian-9-r77" \
    PATH="/opt/bitnami/helm:/opt/bitnami/kubectl/bin:$PATH"

ENTRYPOINT [ "helm" ]
CMD [ "help" ]
