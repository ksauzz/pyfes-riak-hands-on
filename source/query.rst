データ操作
==========

RiakにはHttpとProtocolBufferのAPIが用意されています。
ここではcURLを使ってRiakにHTTPのリクエストを投げてみます。
(個人的にはcURLより `HTTPie <http://github.com/jkbr/httpie#readme>`_ がオススメ）

PUT
------------------------------

::

  curl -X PUT -i 'http://localhost:8098/buckets/accounts/keys/alice' -H 'Content-Type: application/json' -d '{name: "alice", age: 20}'

GET
------------------------------
::

  curl -i 'http://localhost:8098/buckets/accounts/keys/alice'

DELETE
------------------------------

::

  curl -X DELETE -i 'http://localhost:8098/buckets/accounts/keys/alice'

Bucket一覧
------------------------------

::

  curl -i 'http://localhost:8098/buckets?buckets=true'

Key一覧
------------------------------

::

  curl -i 'http://localhost:8098/buckets/accounts/keys?keys=true'

stats
------------------------------

::

  curl -i 'http://localhost:8098/stats'

ping
------------------------------

::

  curl -i 'http://localhost:8098/ping'
