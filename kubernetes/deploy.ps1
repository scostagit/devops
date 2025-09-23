$ClusterName = "mycluster"
$DeployFile = "deploy.yaml"

Write-Host "🔎 Checking if k3d cluster '$ClusterName' exists..."
$clusterList = k3d cluster list
if ($clusterList -notmatch $ClusterName) {
    Write-Host "🚀 Cluster not found. Creating k3d cluster '$ClusterName'..."
    k3d cluster create $ClusterName
} else {
    Write-Host "✅ Cluster '$ClusterName' exists."
    Write-Host "🔄 Ensuring cluster is running..."
    k3d cluster start $ClusterName
}

Write-Host "🔧 Switching kubectl context to k3d-$ClusterName..."
kubectl config use-context "k3d-$ClusterName"

Write-Host "📡 Verifying cluster connectivity..."
kubectl cluster-info
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Could not connect to cluster. Exiting."
    exit 1
}

Write-Host "📦 Applying Kubernetes manifests..."
kubectl apply -f $DeployFile

Write-Host "✅ Done! Your Deployment and Service should now be running."
Write-Host "💡 Check with: kubectl get pods, kubectl get svc"
