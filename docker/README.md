# Docker Samples

Build

```
$ docker-compose build [service]
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
