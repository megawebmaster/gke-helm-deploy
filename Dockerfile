FROM bitnami/kubectl:1.18.8-debian-10-r14
LABEL maintainer="amadeusz.starzykiewicz@u2i.com"

# Install helm
RUN mkdir -p /opt/bitnami/helm
RUN wget -qO /tmp/helm.tar.gz https://get.helm.sh/helm-v3.3.1-linux-amd64.tar.gz && \
    echo "81e3974927b4f76e9f679d1f6d6b45748f8c84081a571741d48b2902d816e14c /tmp/helm.tar.gz" | sha256sum -c - && \
    tar -xzf /tmp/helm.tar.gz --strip-components=1 -C /opt/bitnami/helm linux-amd64/helm && \
    rm -rf /tmp/helm.tar.gz
RUN chmod +x /opt/bitnami/helm/helm

ENV BITNAMI_APP_NAME="helm" \
    BITNAMI_IMAGE_VERSION="3.3.1-debian-10-r14" \
    PATH="/opt/bitnami/helm:$PATH"

ENTRYPOINT [ "helm" ]
CMD [ "help" ]
