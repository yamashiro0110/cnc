# Envoy

envoyやってみた。

- https://www.envoyproxy.io/
- https://www.envoyproxy.io/docs/envoy/latest/
- https://github.com/envoyproxy/envoy

アーキテクチャ、envoyを構成する要素等
> https://www.envoyproxy.io/docs/envoy/v1.18.2/intro/arch_overview/arch_overview

envoyの用語等
> https://www.envoyproxy.io/docs/envoy/v1.18.2/intro/arch_overview/intro/terminology

リクエストの処理の概要
> https://www.envoyproxy.io/docs/envoy/v1.18.2/intro/life_of_a_request#high-level-architecture

リクエストを受信してレスポンスするまでの流れ
> https://www.envoyproxy.io/docs/envoy/v1.18.2/intro/life_of_a_request#request-flow

memo: 構成のイメージ

```
envoy:
  listener:
    listenerの設定
    filter_chain:
      - filter-1:
        filterの設定
      - filter-2
        filterの設定
      - filter-3
        filterの設定
      - http-connection-manager(httpリクエストを処理する場合)
          routingの設定
            clusterの設定
          http_filterの設定
            - http_filter-1:
              http_filterの設定
            - http_filter-2:
              http_filterの設定
  cluster:
    load_balancerの設定:
      endpointの設定等
```

Listener filters
- filter_chainを開始する前に実行できるfilterらしい
- プロトコルの判定、TLSの判定とかが出来る(という記載があるようだけど、用途がよくわからん)
- L3,L4の接続情報を操作する場合に使うっぽい(?)
> https://www.envoyproxy.io/docs/envoy/v1.18.2/intro/arch_overview/listeners/listener_filters.html?highlight=listener%20filters
> https://www.envoyproxy.io/docs/envoy/v1.18.2/intro/arch_overview/listeners/listeners#listeners


## Conf

example
> https://www.envoyproxy.io/docs/envoy/v1.18.2/intro/life_of_a_request#configuration

Listener
> https://www.envoyproxy.io/docs/envoy/v1.18.2/api-v3/config/listener/v3/listener.proto

typed_config
- filter毎に固有の設定をする場合の項目
> https://www.envoyproxy.io/docs/envoy/v1.18.2/api-v3/config/listener/v3/listener_components.proto#extension-category-envoy-filters-listener

### HTTP

https://www.envoyproxy.io/docs/envoy/v1.18.2/intro/arch_overview/http/http

HTTP connection management
- HTTPリクエストのフィルタやレスポンスを操作することが出来る
- HTTP/1.1, WebSockets, and HTTP/2をデフォルトでサポートしている
- リクエストのルーティングが出来る
- リクエストが失敗したときのリトライ
- リダイレクトのサポート
> https://www.envoyproxy.io/docs/envoy/v1.18.2/intro/arch_overview/http/http_connection_management
> https://www.envoyproxy.io/docs/envoy/v1.18.2/api-v3/extensions/filters/network/http_connection_manager/v3/http_connection_manager.proto

HTTP filters
- filterは定義した順に適用される
- `http_filters`は`http_connection_manager`のフィールドになっている
> https://www.envoyproxy.io/docs/envoy/v1.18.2/intro/arch_overview/http/http_filters
> https://www.envoyproxy.io/docs/envoy/v1.18.2/api-v3/extensions/filters/network/http_connection_manager/v3/http_connection_manager.proto#envoy-v3-api-field-extensions-filters-network-http-connection-manager-v3-httpconnectionmanager-http-filters

HTTP routing
- ルーティングできる条件が色々ある
- ex) VirtualHost, Pathの正規表現のパターン, ルーティングせずにEnvoyでレスポンスを返す, HTTPヘッダ
> https://www.envoyproxy.io/docs/envoy/v1.18.2/intro/arch_overview/http/http_routing

#### External Authorization

リクエストを外部サービスに委譲して、認証・認可を実行できる。
`HTTP filters`として設定する。
> https://www.envoyproxy.io/docs/envoy/v1.18.2/intro/arch_overview/security/ext_authz_filter#arch-overview-ext-authz
> https://www.envoyproxy.io/docs/envoy/v1.18.2/configuration/http/http_filters/ext_authz_filter#config-http-filters-ext-authz
> https://www.envoyproxy.io/docs/envoy/v1.18.2/api-v3/extensions/filters/http/ext_authz/v3/ext_authz.proto#envoy-v3-api-msg-extensions-filters-http-ext-authz-v3-extauthz

## Usage

```sh
$ docker-compose up
```

External Authorization

- 認証に成功する場合

```sh
$ curl --location --request GET 'http://envoy.localtest.me:8080/' \
--header 'Authorization: Bearer pen-pineapple-Apple-pen'

{
    "msg": "Hello World!!"
}
```

- 認証に失敗する場合
  - `envoy.filters.http.ext_authz`に設定した`http_filters`にリクエストを転送して、`ext_authz-http-service`で認証・認可を実行する
  - 無効なBearer Tokenのため、`ext_authz-http-service`からレスポンスがエラーで返される
  - エラーの場合は、`ext_authz-http-service`のレスポンスがenvoyから返される

```sh
$ curl --location --request GET 'http://envoy.localtest.me:8080/' \
--header 'Authorization: Bearer invalid_token'

{
    "msg": "success Authentication, Valid Bearer Token",
    "api_key": "Bearer invalid_token",
    "request_headers": {
        "HTTP_HOST": "envoy.localtest.me:8080",
        "HTTP_AUTHORIZATION": "Bearer invalid_token",
        "HTTP_X_ENVOY_INTERNAL": "true",
        "HTTP_X_FORWARDED_FOR": "172.30.0.4",
        "HTTP_X_ENVOY_EXPECTED_RQ_TIMEOUT_MS": "250",
        "HTTP_VERSION": "HTTP/1.1"
    }
}
```
