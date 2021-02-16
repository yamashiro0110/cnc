# Keycloak

`keycloak`を使ってリバースプロキシ型構成の認証/認可を構築する。

## 構成・役割

- OpenID Provider(OP): keycloak

- Relying Party(RP): mod_auth_openidc
  - リバースプロキシとしてリクエストの認可を実行する
  - 認可されたリクエストをアプリケーションに転送する

- Application: backend-1, backend-2
  - mod_auth_openidcで保護されたリソース

## ユースケース

リバースプロキシ型構成の認証/認可を構築して実現したいこと。

- アプリケーションを利用するユーザーのグループを作成する
- グループにはadminユーザーが存在し、グループの作成時に追加される
- グループにはユーザーを追加できる

- アプリケーションには、ロール(役割)が存在し、ユーザー・グループに設定出来る
- アプリケーションには、リソースが存在し、リソースに対する操作は権限が必要になる
- リソースに対する操作の権限は、ユーザーのロールによって決定される

- アプリケーションのユーザーは、アプリケーション内でユーザーを識別するID(ユーザーID)が割り当てられる
  - ユーザーIDは、拡張されたユーザー属性情報のためscopeを設定する

## 設定等

1. keycloakの設定([ここ](./setup_keycloak.md))
2. mod_auth_openidcの設定([ここ](./setup_mod_auth_openidc.md))

[realm-export.json](./realm-export.json)に、keycloakの設定をエクスポートした。

## 使い方

```sh
$ docker-compose up
```

- keycloak
  - http://keycloak.localtest.me:8080/

- OpenID Connect プロキシ
  - https://oidc-proxy.localtest.me:443/

- OAuth2.0 プロキシ
  - https://oauth-proxy.localtest.me:443/

## 参考

- https://www.atmarkit.co.jp/ait/articles/1810/22/news011.html
- https://www.atmarkit.co.jp/ait/articles/1904/03/news003.html
- https://www.atmarkit.co.jp/ait/articles/1912/06/news008.html
- https://keycloak-documentation.openstandia.jp/
- https://www.keycloak.org/
- https://www.keycloak.org/getting-started
- https://www.keycloak.org/getting-started/getting-started-docker
- https://www.keycloak.org/documentation
- https://www.keycloak.org/docs-api/12.0/rest-api/index.html
- https://www.openid.or.jp/document/
- https://qiita.com/TakahikoKawasaki/items/8f0e422c7edd2d220e06
- https://qiita.com/TakahikoKawasaki/items/185d34814eb9f7ac7ef3
- https://qiita.com/TakahikoKawasaki/items/4ee9b55db9f7ef352b47
