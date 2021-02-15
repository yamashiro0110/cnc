# Keycloak

`Keycloak`を動かしてみる。
> https://www.keycloak.org/getting-started/getting-started-docker

Keycloakの設定等については、[ここ](./docs/README.md)を参照。

[realm-export.json](./realm-export.json)に、keycloakの設定をエクスポートした。

## Usage

```sh
$ docker-compose up
```

`http://keycloak.localtest.me:8080/auth/`にアクセスする。
