# Sinatra

envoyでプロキシするBackend Service

## Requirements

- docker
- docker-compose

## Usage

```sh
$ docker-compose up
```

Beader Token Authentication

```sh
$ curl --location --request GET 'http://auth.localtest.me:10080/' \
--header 'Authorization: Bearer pen-pineapple-Apple-pen'

{
    "msg": "success Authentication, Invalid Bearer Token",
    "api_key": "Bearer pen-pineapple-Apple-pen",
    "request_headers": {
        "HTTP_AUTHORIZATION": "Bearer pen-pineapple-Apple-pen",
        "HTTP_USER_AGENT": "PostmanRuntime/7.26.8",
        "HTTP_ACCEPT": "*/*",
        "HTTP_POSTMAN_TOKEN": "71f42d3b-469b-4994-89ef-b621665330e8",
        "HTTP_HOST": "auth.localtest.me:10080",
        "HTTP_ACCEPT_ENCODING": "gzip, deflate, br",
        "HTTP_CONNECTION": "keep-alive",
        "HTTP_VERSION": "HTTP/1.1"
    }
}
```

Hello World!!

```sh
$ curl --location --request GET 'http://auth.localtest.me:10081/'

{
    "msg": "Hello World!!"
}
```
