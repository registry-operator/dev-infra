# Development infrastructure

This repository serves as the central hub for managing the development infrastructure using Flux and Renovate. Flux is a
GitOps tool that ensures the Git repository is the single source of truth for the desired state of the cluster, while 
Renovate automates dependency updates across various files in the repository. By leveraging these tools, developers can
maintain a consistent and up-to-date development environment with minimal manual intervention. The repository contains
configuration files, manifests, and scripts necessary to orchestrate the deployment and management of services within
the Kubernetes cluster. Additionally, it provides a structured approach for version control and collaboration, enabling
seamless integration of new features and updates into the development workflow.

## Getting Started

### Installing all components

To install all components, follow these steps:

1. Set up your GitHub token by exporting it as an environment variable:
    ```sh
    export GITHUB_TOKEN='<my-token>'
    ```
1. Run the following command to bootstrap Flux on your Kubernetes cluster:
    ```sh
    flux bootstrap github \
        --token-auth \
        --owner=registry-operator \
        --repository=dev-infra \
        --branch=main \
        --path='clusters/dev'
    ```

### Customizing deployments

If you want to customize deployments, you'll need to fork the repository first. Follow these steps:

1. Fork the repository to your GitHub account.
1. Set up your GitHub token by exporting it as an environment variable:
    ```sh
    export GITHUB_TOKEN='<my-token>'
    ```
1. Run the following command to bootstrap Flux using your forked repository:
    ```sh
    flux bootstrap github \
        --token-auth \
        --owner='<your-username>' \
        --repository=dev-infra \
        --branch='<dev-branch>' \
        --path='clusters/dev' \
        --personal
    ```

Now you're ready to customize and manage your deployments according to your needs.

## Accessing services

| Service    | Command                                                                     | Access                                           |
|------------|-----------------------------------------------------------------------------|--------------------------------------------------|
| Jaeger     | `kubectl port-forward -n=observability svc/jaeger-query 10080:80`           | [http://localhost:10080](http://localhost:10080) |
| Parca      | `kubectl port-forward -n=parca-system svc/parca-server 10180:7070`          | [http://localhost:10180](http://localhost:10180) |
| Prometheus | `kubectl port-forward -n=prometheus-system svc/prometheus-server 10280:80`  | [http://localhost:10280](http://localhost:10280) |
| S3GW       | `kubectl port-forward -n=kube-system svc/s3gw-kube-system-ui-s3gw 10380:80` | [http://localhost:10380](http://localhost:10380) |

## FAQ

1. **Why no Grafana?**
    The main disadvantage is time. Managing Grafana and making sure the updates are not breaking the cluster, dashboards and data sources requires too much effort for our liking.
2. **Why no logs collection?**
    Like with the Grafana - this would turn the dev clusters from cattle to pets, especially if we consider _Loki_ and _Promtail_ setup. Ain't nobody got time for this.
