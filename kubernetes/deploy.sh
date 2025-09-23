#!/bin/bash

CLUSTER_NAME="mycluster"
DEPLOY_FILE="deploy.yaml"

echo "🔎 Checking if k3d cluster '$CLUSTER_NAME' exists..."
if ! k3d cluster list | grep -q "$CLUSTER_NAME"; then
  echo "🚀 Cluster not found. Creating k3d cluster '$CLUSTER_NAME'..."
  k3d cluster create "$CLUSTER_NAME"
else
  echo "✅ Cluster '$CLUSTER_NAME' exists."
  echo "🔄 Ensuring cluster is running..."
  k3d cluster start "$CLUSTER_NAME"
fi

echo "🔧 Switching kubectl context to k3d-$CLUSTER_NAME..."
kubectl config use-context "k3d-$CLUSTER_NAME"

echo "📡 Verifying cluster connectivity..."
kubectl cluster-info || { echo "❌ Could not connect to cluster. Exiting."; exit 1; }

echo "📦 Applying Kubernetes manifests..."
kubectl apply -f "$DEPLOY_FILE"

echo "✅ Done! Your Deployment and Service should now be running."
echo "💡 Check with: kubectl get pods, kubectl get svc"
