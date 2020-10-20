# Docker Samples

Build all

```
$ docker-compose build [service]
```

Build single container

```
$ cd [project root]
$ docker build . -t [tag name]
```

Run all containers

```
$ docker-compose up -d
$ docker ps
```

Run single container

```
$ docker-compose up -d [service]
```

or 

```
$ cd [project space]
$ docker run -it --rm -v ${PWD}:/work -w /work [image] bash
```

or 

```
$ cd [project space]
$ docker run -it --rm -v ${PWD}:/work -p 8080:8080 [image]
```

Enter inside a container

```
$ docker exec -it [service] sh
```

Production

```
$ docker-compose up
```

__Note:__ Change target to 'prod' and comment out working_dir, entrypoint, stdin_open and tty for build.target:prod 

Misc

- Checkout launch.json for debug mode configurations on VSCode
- Install plugins by Microsoft (Python and Docker)
