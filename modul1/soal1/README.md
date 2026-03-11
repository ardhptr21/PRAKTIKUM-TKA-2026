# Walkthrough Soal 1

1. build

```sh
docker build -t eva-web-a07:v1 .
docker build -t eva-web-a07:v2 .
```

2. run

```sh
docker run -d --name eva-container-a07-v1 -p 8080:80 eva-web-a07:v1 && \
docker run -d --name eva-container-a07-v2 -p 8081:80 eva-web-a07:v2
```

3. volume

```sh
docker stop eva-container-a07-v1
docker rm eva-container-a07-v1

docker run -d --name eva-container-a07-v1 \
  -p 8080:80 \
  -v $PWD/v1:/usr/share/nginx/html \
  eva-web-a07:v1
```

4. exec

```sh
docker exec -it eva-container-a07-v2 bash
```
