FROM bitnami/kubectl:1.18.3
LABEL maintainer="amadeusz.starzykiewicz@u2i.com"

# Install helm
RUN mkdir -p /opt/bitnami/helm
RUN wget -O /tmp/helm.tar.gz https://get.helm.sh/helm-v3.2.1-linux-amd64.tar.gz && \
    echo "018f9908cb950701a5d59e757653a790c66d8eda288625dbb185354ca6f41f6b /tmp/helm.tar.gz" | sha256sum -c - && \
    tar -xzf /tmp/helm.tar.gz --strip-components=1 -C /opt/bitnami/helm linux-amd64/helm && \
    rm -rf /tmp/helm.tar.gz
RUN chmod +x /opt/bitnami/helm/helm

# Set required variables
ENV KUBECONFIG=/tmp/kubeconfig.yaml
ENV GOOGLE_APPLICATION_CREDENTIALS=/tmp/google-key.json

ENV BITNAMI_APP_NAME="helm" \
    BITNAMI_IMAGE_VERSION="3.2.1-debian-10-r14" \
    PATH="/opt/bitnami/helm:$PATH"

ENTRYPOINT [ "helm" ]
CMD [ "help" ]
