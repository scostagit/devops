kubectl create secret generic pagina-ngx --from-file ./index.html

kubectl get secret

kubectl describe secret pagina-nginx

 kubectl apply -f deployment.yaml                                  

 kubectl get po

 kubectl get service

 kubectl port-forward svc/nginx 8080:80