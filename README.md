# Retail Store Deployment Using GitOps

## Overview

This project is a Proof of Concept (POC) demonstrating an automated deployment and management system for retail stores using GitOps practices. The system ensures rapid rollouts, consistent configurations, and secure updates for POS systems and in-store devices.

Access to the presentation and demo of the POC is here: 

<a href="https://app.filmora.io/#/object/cubs7bktmqn905j788og?source=%7B%22product_id%22:%221901%22,%22product_page%22:%22share_url%22,%22product_version%22:%2214.2.4.10800%22%7D)" target="_blank">Demo Walkthrough!</a>

## Features

- **Infrastructure as Code (IaC)**: 

  - Managed using Terraform for AKS cluster and networking setup.

- **POS Management**:

  - Helm charts for deploying POS applications across multiple stores.

  - Store-specific configurations managed through Helm values files.

- **Monitoring and Alerting**:

  - Prometheus for metrics collection.

  - Grafana for visualization with pre-configured dashboards.

- **Security and Compliance**:

  - Kubernetes Secrets for sensitive data.

  - Open Policy Agent (OPA) for policy enforcement.

- **Scalability**:

  - Easily onboard new stores using reusable Helm charts.

## Repository Structure

├──retail-store/ \ 
    ├── argo-apps/ # Argo CD application manifests │ ├── store1/ │ └── store2/ \
  ├── helm/ # Helm charts for POS and monitoring │ \
      ├── pos-system/ │ \
      ├── monitoring/ \
  ├── infrastructure/ # Terraform code for AKS and networking │ \
      ├── modules/ # Reusable Terraform modules │ ├── dev/ # Environment-specific Terraform configs │ ├── prod/ │ ├── test/ \
  ├── Policies/ # \
  ├── scripts/ # Automation and utility scripts \
  ├── README.md # Project overview and instructions 

## Prerequisites

- Azure CLI

- Terraform

- Helm

- kubectl

- Argo CD CLI

- Prometheus and Grafana configured in the cluster.

## Setup Instructions

### 1. Clone the Repository
```
git clone https://github.com/SpelmanDevops/retail-store.git

cd retail-store
```
### 2. Deploy Infrastructure

Navigate to the infrastructure/ directory and deploy the AKS cluster:
```
cd infrastructure/dev

terraform init

terraform apply
```
### 3. Deploy POS Applications

Deploy the POS system for Store 1 and Store 2 using Helm:
```
helm upgrade --install pos-system-store1 ./helm/pos-system --namespace store1

helm upgrade --install pos-system-store2 ./helm/pos-system --namespace store2 -f ./helm/pos-system/values-store2.yaml
```
### 4. Configure Monitoring

Ensure Prometheus and Grafana are deployed via Helm:
```
helm upgrade --install monitoring ./helm/monitoring --namespace monitoring
```
Access Grafana dashboards for metrics and alerts.

### 5. Add Applications to Argo CD

Apply Argo CD manifests for Store 1 and Store 2:
```
kubectl apply -f argo-apps/store1/pos-system-store1.yaml

kubectl apply -f argo-apps/store2/pos-system-store2.yaml
```
Sync applications in Argo CD:
```
argocd app sync pos-system-store1

argocd app sync pos-system-store2
```
#### Monitoring Dashboards:

&nbsp;&nbsp;&nbsp;&nbsp;Kubernetes / Compute Resources / Namespace (Pods): Resource usage per namespace.

&nbsp;&nbsp;&nbsp;&nbsp;Kubernetes / Networking / Namespace (Pods): Network metrics for pods.

&nbsp;&nbsp;&nbsp;&nbsp;Kubernetes / Compute Resources / Node: Node-level metrics for resource management.

#### Troubleshooting Common Issues:

Pods in Pending State:

Check node resource availability:
```
kubectl describe nodes
```
Scale up the node pool if required.

Secrets Missing:

Ensure pos-secrets are created in the respective namespaces:
```
kubectl create secret generic pos-secrets --namespace store1 --from-literal=api-key=<your-api-key>

kubectl create secret generic pos-secrets --namespace store2 --from-literal=api-key=<your-api-key>
```
Argo CD Sync Failures:

Ensure the manifests and repository paths are correct.

## Future Enhancements

Integration with CI/CD pipelines for automated deployments.

Enhanced monitoring with log aggregation using Loki or ELK stack.

Improved security with HashiCorp Vault.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

