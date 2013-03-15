.. Riak Hands-on documentation master file, created by
   sphinx-quickstart on Fri Mar 15 15:54:45 2013.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Erlang R15B01のインストール
=========================================

ソースのダウンロード
--------------------

ソース(R15B01)を http://erlang-users.jp からダウンロード＆インストール

(本家からだと時間が掛かるので日本のミラーからダウンロードがオススメ)

::

    wget http://download.basho.co.jp.cs-ap-e1.ycloud.jp/download/otp_src_R15B01.tar.gz
    tar zxfv otp_src_R15B01.tar.gz
    cd otp_src_R15B01

configureを実行
---------------
--prefixには自分がインストールしたいpathを指定すること

- Mac

  ::

      ./configure --prefix=/user/local/erlang/R15B01 --disable-hipe --enable-smp-support --enable-threads --enable-kernel-poll  --enable-darwin-64bit

- Linux

  ::

      ./configure --prefix=/user/local/erlang/R15B01 --disable-hipe --enable-smp-support --enable-threads --enable-kernel-poll

ビルド＆インストール
--------------------

::

  make
  sudo make install


~/.bash_profile or ~/.zshenvに以下を追記する

::

  export PATH=$PATH:/usr/local/erlang/R15B01/bin


インストールの確認
------------------

erl が起動すればインストール成功

::

  % erl
  Erlang R15B01 (erts-5.9.1) [source] [64-bit] [smp:4:4] [async-threads:0] [kernel-poll:false]

  Eshell V5.9.1  (abort with ^G)
  1>


Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

