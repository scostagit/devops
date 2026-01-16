kubectl create configmap pagina-ngx --from-file ./index.html

kubectl get configmap

kubectl describe configmap pagina-nginx

 kubectl apply -f deployment.yaml