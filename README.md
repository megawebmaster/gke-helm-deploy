# Docker GKE Helm deployment image

Docker image that can run Helm deploys on Kubernetes in Google Cloud!

This image is based on Bitnami's `kubectl` image.

## Versions

Image   | kubectl | Helm  
------- | ------- | -----
3.0.2-1 | 1.12.10 | 3.0.2
3.2.1-1 | 1.18.3  | 3.2.1

# How to use it?

1. Generate your `kubeconfig.yaml` file using `build-kubeconfig.sh` command
    > cluster=your-cluster-name zone=your-zone ./build-kubeconfig.sh
2. Add generated file to your project's repository
3. Add Jenkins stage that binds `kubeconfig.yaml`, Google Cloud key files and your chart 
into the image and run `upgrade your-deployment-name /root/chart` 

## Security

The `kubeconfig.yaml` file we generated here is safe to add to even public repositories.
It contains no credentials, just points to your cluster.

Based on: https://ahmet.im/blog/authenticating-to-gke-without-gcloud/
