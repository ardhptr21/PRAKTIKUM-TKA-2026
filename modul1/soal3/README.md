# Walkthrough Soal 3

1. build

```sh
docker build -t eva-web-a07:v1 .
```

2. run

```sh
docker run -d --name eva-container-a07 \
  -p 8080:80 \
  -v $PWD/app:/usr/share/nginx/html/ \
  -v $PWD/logs:/var/log/nginx \
  eva-web-a07:v1
```

3. exec

```sh
docker exec -it eva-container-a07 bash
```

4. logs container

```sh
docker logs -f eva-container-a07
```

5. statistics

```sh
docker ps

docker images

docker stats eva-container-a07
```

6. stop remove

```sh
docker stop eva-container-a07
docker rm eva-container-a07
docker rmi eva-web-a07:v1
```
