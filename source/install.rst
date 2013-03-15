Riakのインストール
=========================================

ビルド
------

::

  wget http://download.basho.co.jp.cs-ap-e1.ycloud.jp/download/riak-1.3.0.tar.gz
  tar zxvf riak-1.3.0.tar.gz
  cd riak-1.3.0
  make rel

起動
----

::

  cd rel/riak
  bin/riak start

起動確認
---------

::

  % curl -i http://localhost:8098/ping
  HTTP/1.1 200 OK
  Server: MochiWeb/1.1 WebMachine/1.9.2 (someone had painted it blue)
  Date: Fri,  15 Mar 2013 14:12:05 GMT
  Content-Type: text/html
  Content-Length: 2

  OK
