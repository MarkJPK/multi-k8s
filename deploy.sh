# Build the images
docker build -t markjpk/multi-client:latest -t markjpk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t markjpk/multi-server:latest -t markjpk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t markjpk/multi-worker:latest -t markjpk/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Push the images to Docker Hub
docker push markjpk/multi-client:latest
docker push markjpk/multi-server:latest
docker push markjpk/multi-worker:latest

docker push markjpk/multi-client:$SHA
docker push markjpk/multi-server:$SHA
docker push markjpk/multi-worker:$SHA

# Apply the Kubernetes configuration files
kubectl create namespace complex
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=markjpk/multi-client:$SHA
kubectl set image deployments/server-deployment server=markjpk/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=markjpk/multi-worker:$SHA
