# Keycloak Standalone Cluster - Example

Keycloak スタンドアローン・クラスタモードをやってみた。

## Usage

```sh
$ docker-compose up
```

- http://keycloak.localtest.me/
  - ID/PW: root / root

- http://keycloak.localtest.me/balancer-manager
  - Apache HTTP Server - Load Balancer Manager

## クラスタモードのメモ

スタンドアローン・クラスタモードとドメイン・クラスタモードがある。

### [スタンドアローン・クラスタモード](https://keycloak-documentation.openstandia.jp/master/ja_JP/server_installation/index.html#_standalone-ha-mode)

スタンドアローン・クラスタモードとは。

> スタンドアローン・クラスター動作モードは、クラスター内でKeycloakを実行するためのものです。このモードでは、サーバー・インスタンスを実行する各マシンにKeycloakの配布物のコピーが保存されている必要があります。このモードは、最初は非常に簡単にデプロイできますが、後でかなり煩雑になる可能性があります。設定を変更するには、各マシンの配布物を修正する必要があります。大規模なクラスターの場合、時間がかかり、エラーも発生しやすくなります。

Fargateとかk8sが使えるなら、スタンドアローン・クラスタモードでも、ドメイン・クラスタモードと同じことができそう。

### [ドメイン・クラスタモード](https://keycloak-documentation.openstandia.jp/master/ja_JP/server_installation/index.html#_domain-mode)

ドメイン・クラスタモードとは。

> ドメインモードとは、サーバーの設定を一元管理し、クラスター内の各サーバーに反映させる方法です。
> 標準モードでクラスターを実行すると、クラスターが大きくなり、煩雑化する可能性があります。クラスター内の各ノードにおいて、都度設定を変更する必要がでてきてしまいます。一方、ドメインモードの場合は、設定を保存しパブリッシュするために一元管理する場所を提供することで、この問題を解決できます。セットアップにはかなり手間がかかりますが、最終的にはその工数は見合うことになります。この機能はKeycloakが構成されるWildFlyアプリケーション・サーバーに組み込まれています。


ドメイン・クラスタモードのロードバランサーサービスはテスト用らしい。
> ロードバランサーは必須サービスではありません。これは、開発マシン上でクラスタリングを簡単にテストできるようにするものです。プロダクション環境で使用可能ですが、使いたい別のハードウェアまたはソフトウェア・ベースのロードバランサーがあるなら、置き換えるかどうかを選択できます。

[クラスター構成ドメインのサンプル](https://keycloak-documentation.openstandia.jp/master/ja_JP/server_installation/index.html#_clustered-domain-example)
> そのまま利用可能な domain.xml 設定を使用してクラスタリングをテストできます。このサンプルドメインは、1台のマシンで実行され、以下を起動します。

### セッション

セッションのデータ保存先は`Infinispan`(Infinispanキャッシュ)になっているらしい。
> https://keycloak-documentation.openstandia.jp/master/ja_JP/server_installation/#technicaldetails
> https://keycloak-documentation.openstandia.jp/master/ja_JP/server_installation/#cache

Keycloakをクラスタリングして動かすとき、スティッキー・セッションの設定。
Infinispanキャッシュでセッションを永続化しない場合は、ロードバランサでスティッキー・セッションの設定が必要になりそう。
> https://keycloak-documentation.openstandia.jp/master/ja_JP/server_installation/#sticky-sessions

## NOTE

- https://github.com/keycloak/keycloak-containers/tree/12.0.2/server
