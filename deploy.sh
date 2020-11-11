docker build -t spraguesy/multi-client:latest -t spraguesy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t spraguesy/multi-server:latest -t spraguesy/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t spraguesy/multi-worker:latest -t spraguesy/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push spraguesy/multi-client:latest
docker push spraguesy/multi-server:latest
docker push spraguesy/multi-worker:latest
docker push spraguesy/multi-client:$SHA
docker push spraguesy/multi-server:$SHA
docker push spraguesy/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=spraguesy/multi-server:$SHA
kubectl set image deployments/client-deployment client=spraguesy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=spraguesy/multi-worker:$SHA

