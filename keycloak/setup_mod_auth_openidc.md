# Setup mod_auth_openidc

`mod_auth_openidc`で、Relying Party(RP)を用意する。

## Apache

`mod_auth_openidc`は、`Apache HTTP Server`([Apache](http://httpd.apache.org/))のmoduleなので、Apacheの環境を用意する。

Apacheのimageは、[Dockerfile](./mod_auth_openidc/Dockerfile)で定義している。
> [ここ](https://github.com/zmartzone/mod_auth_openidc/blob/master/Dockerfile-alpine)から、引用している

## mod_auth_openidcの設定

Apache(Apache HTTP Server)の設定ファイルをincludeされるディレクトリに作成する。

今回の例では、[mod_auth_openidc/openidc.conf](./mod_auth_openidc/openidc.conf)に作成して、
`docker-compose`のvolumeでincludeされるディレクトリにmountしている。

[docker-compose.yml](./docker-compose.yml)から一部抜粋。

```yml
  mod_auth_openidc:
    volumes:
      - ./mod_auth_openidc/openidc.conf:/etc/apache2/conf.d/openidc.conf
```

`mod_auth_openidc`の設定については下記を参照。

- https://github.com/zmartzone/mod_auth_openidc/wiki/Authorization
- https://github.com/zmartzone/mod_auth_openidc/blob/master/auth_openidc.conf
