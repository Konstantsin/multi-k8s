docker build -t kswest.azurecr.io/ksavon/multi-client:latest -t kswest.azurecr.io/ksavon/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kswest.azurecr.io/ksavon/multi-server:latest -t kswest.azurecr.io/ksavon/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kswest.azurecr.io/ksavon/multi-worker:latest -t kswest.azurecr.io/ksavon/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kswest.azurecr.io/ksavon/multi-client:latest
docker push kswest.azurecr.io/ksavon/multi-server:latest
docker push kswest.azurecr.io/ksavon/multi-worker:latest

docker push kswest.azurecr.io/ksavon/multi-client:$SHA
docker push kswest.azurecr.io/ksavon/multi-server:$SHA
docker push kswest.azurecr.io/ksavon/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployment/server-deployment server=kswest.azurecr.io/ksavon/multi-server:$SHA
kubectl set image deployment/client-deployment client=kswest.azurecr.io/ksavon/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=kswest.azurecr.io/ksavon/multi-worker:$SHA