# digdag

digdagやってみた
> https://docs.digdag.io/index.html

## Requirements

- docker(>= 20.10.6)
- brew(>= 3.2.1)

## Install

digdag serverにpushするため、digdagをinstallする

```sh
$ brew install digdag
```

```sh
$ digdag version
2021-07-08 14:32:19 +0900: Digdag v0.10.1
Client version: 0.10.1
Server version: 0.10.1
```

## Usage

start digdag server
> `http://127.0.0.1:65432`で、digdag uiが起動する

```
$ docker-compose up
```

digdag push

```sh
$ digdag push sample --project sample -r "$(date +%Y-%m-%dT%H:%M:%S%z)"

2021-07-08 14:31:46 +0900: Digdag v0.10.1
Creating .digdag/tmp/archive-2122612649086503481.tar.gz...
  Archiving sample.dig
Workflows:
  sample.dig
Uploaded:
  id: 1
  name: sample
  revision: 2021-07-08T14:31:46+0900
  archive type: db
  project created at: 2021-07-08T05:23:26Z
  revision updated at: 2021-07-08T05:31:48Z

Use `digdag workflows` to show all workflows.
```

digdag start

```sh
$ digdag start sample sample --session now

2021-07-08 14:33:43 +0900: Digdag v0.10.1
Started a session attempt:
  session id: 33
  attempt id: 33
  uuid: d0857222-392f-446b-96f9-c740ab2f6f06
  project: sample
  workflow: sample
  session time: 2021-07-08 14:33:44 +0900
  retry attempt name:
  params: {}
  created at: 2021-07-08 14:33:45 +0900

* Use `digdag session 33` to show session status.
* Use `digdag task 33` and `digdag log 33` to show task status and logs.
```

digdag log

```sh
$ digdag log 33

2021-07-08 14:35:32 +0900: Digdag v0.10.1
```

digdag session

```sh
$ digdag session 33

2021-07-08 14:35:41 +0900: Digdag v0.10.1
  session id: 33
  attempt id: 33
  uuid: d0857222-392f-446b-96f9-c740ab2f6f06
  project: sample
  workflow: sample
  session time: 2021-07-08 14:33:44 +0900
  retry attempt name:
  params: {}
  created at: 2021-07-08 14:33:45 +0900
  kill requested: false
  status: success
```
