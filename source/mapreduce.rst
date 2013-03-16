Map Reduce
=========================================

RiakではJavascriptもしくはErlangで関数を定義することでMapReduceを実行することができます。
ここではJavascriptを使ったMapReduceを紹介。

データの準備
------------

テストデータをRiakへ流し込みます。

::

  $ wget http://resource.basho.co.jp.cs-ap-e1.ycloud.jp/pyfes-hands-on/sample/load_data.erl
  $ wget http://resource.basho.co.jp.cs-ap-e1.ycloud.jp/pyfes-hands-on/sample/goog.csv
  $ chmod +x load_data
  $ ./load_data goog.csv

MapReduceの実行
---------------

Javascriptを使ってMapReduceを実行します。
下記のJavascriptはHighの値が600より大きいものを返すものです。

::

  {"inputs":"goog",
   "query":[{"map":{"language":"javascript",
                    "source":"function(value, keyData, arg) { var data = Riak.mapValuesJson(value)[0]; if(data.High && parseFloat(data.High) > 600.00) return [value.key]; else return [];}",
                    "keep":true}}]
  }


これをcurlを使って実行します。

::

  $ wget https://github.com/basho/basho_docs/raw/master/source/data/sample-highs-over-600.json
  $ curl -i -X POST http://localhost:8098/mapred -H 'Content-Type: application/json' -d @sample-highs-over-600.json


`他のサンプル <http://docs.basho.com/riak/1.3.0/tutorials/fast-track/Loading-Data-and-Running-MapReduce-Queries/>`_
