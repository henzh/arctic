# Quickbook - Car Service

## Get Started

Run applications

```
$ docker-compose -up
```

Clean docker processes

```
$ docker rm -vf $(docker ps -aq)
```

Psql

```
$ docker exec -it [container] bash
$ psql -h [host] -d [database] -U [username] 
```
