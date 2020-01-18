#!/bin/bash

if [ -z ${cluster} ]; then
	echo 'Please provide a cluster name'
	exit 1
fi

if [ -z ${zone} ]; then
	echo 'Please provide a zone where your cluster is in'
	exit 1
fi

GET_CMD="gcloud container clusters describe ${cluster} --zone=${zone}"

cat > kubeconfig.yaml <<EOF
apiVersion: v1
kind: Config
current-context: gke
contexts: [{name: gke, context: {cluster: gke-1, user: user-1}}]
users: [{name: user-1, user: {auth-provider: {name: gcp}}}]
clusters:
- name: gke-1
  cluster:
    server: "https://$(eval "$GET_CMD --format='value(endpoint)'")"
    certificate-authority-data: "$(eval "$GET_CMD --format='value(masterAuth.clusterCaCertificate)'")"
EOF
