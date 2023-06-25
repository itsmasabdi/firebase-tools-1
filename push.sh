# run bash push.sh to deploy docker image to docker hub

docker build . -t iamasoudabdi/firebase-action
docker push iamasoudabdi/firebase-action