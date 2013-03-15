Riakクラスタ環境の作成
======================

*make devrel* を使ってローカルにRiakクラスタ環境を作ってみます。ここでは以下の様な環境ができます。

- node_name: dev1@127.0.0.1, http_port=10018, pb_port=10017
- node_name: dev2@127.0.0.1, http_port=10028, pb_port=10027
- node_name: dev3@127.0.0.1, http_port=10038, pb_port=10037
- node_name: dev4@127.0.0.1, http_port=10048, pb_port=10047

セットアップ
------------

*make devrel* でdevディレクトリ以下にriakノード環境を４つ作ります。

::

  % make devrel
  ....

  % ls dev
  dev1 dev2 dev3 dev4

ノード起動
-----------

各ノードを起動します。

::

  % dev/dev1/bin/riak start
  % dev/dev2/bin/riak start
  % dev/dev3/bin/riak start
  % dev/dev4/bin/riak start

or


::

  % for dev in dev/dev{1,2,3,4};do $dev/bin/riak start ;done


ここでは、各ノードはまだ孤立した状態です。

::

  % dev/dev1/bin/riak-admin member-status
  ================================= Membership ==================================
  Status     Ring    Pending    Node
  -------------------------------------------------------------------------------
  valid     100.0%      --      'dev1@127.0.0.1'
  -------------------------------------------------------------------------------
  Valid:1 / Leaving:0 / Exiting:0 / Joining:0 / Down:0


クラスタを構成する
--------------------

join -> plan -> commitの3stepでクラスタを構成します。

join
^^^^

dev2からdev4までのノードをdev1ノードへjoinします。

::

  % dev/dev2/bin/riak-admin cluster join dev1
  % dev/dev3/bin/riak-admin cluster join dev1
  % dev/dev4/bin/riak-admin cluster join dev1

or

::

  % for dev in dev/dev{2,3,4};do $dev/bin/riak-admin cluster join dev1 ;done
  Success: staged join request for 'dev2@127.0.0.1' to dev1
  Success: staged join request for 'dev3@127.0.0.1' to dev1
  Success: staged join request for 'dev4@127.0.0.1' to dev1'

plan
^^^^

ノード追加後のクラスタの状態を計画させます

::

  % dev/dev1/bin/riak-admin cluster plan
  =============================== Staged Changes ================================
  Action         Nodes(s)
  -------------------------------------------------------------------------------
  join           'dev2@127.0.0.1'
  join           'dev3@127.0.0.1'
  join           'dev4@127.0.0.1'
  -------------------------------------------------------------------------------


  NOTE: Applying these changes will result in 1 cluster transition

  ###############################################################################
                           After cluster transition 1/1
  ###############################################################################

  ================================= Membership ==================================
  Status     Ring    Pending    Node
  -------------------------------------------------------------------------------
  valid     100.0%     25.0%    'dev1@127.0.0.1'
  valid       0.0%     25.0%    'dev2@127.0.0.1'
  valid       0.0%     25.0%    'dev3@127.0.0.1'
  valid       0.0%     25.0%    'dev4@127.0.0.1'
  -------------------------------------------------------------------------------
  Valid:4 / Leaving:0 / Exiting:0 / Joining:0 / Down:0

  Transfers resulting from cluster changes: 48
    16 transfers from 'dev1@127.0.0.1' to 'dev4@127.0.0.1'
    16 transfers from 'dev1@127.0.0.1' to 'dev3@127.0.0.1'
    16 transfers from 'dev1@127.0.0.1' to 'dev2@127.0.0.1'

commit
^^^^^^

作成したクラスタplanをコミットします。

::

  % dev/dev1/bin/riak-admin cluster commit
  Cluster changes committed

riak-admin member-statusでクラスタの状態を確認します。

::

  % dev/dev1/bin/riak-admin member-status
  ================================= Membership ==================================
  Status     Ring    Pending    Node
  -------------------------------------------------------------------------------
  valid      25.0%      --      'dev1@127.0.0.1'
  valid      25.0%      --      'dev2@127.0.0.1'
  valid      25.0%      --      'dev3@127.0.0.1'
  valid      25.0%      --      'dev4@127.0.0.1'
  -------------------------------------------------------------------------------
  Valid:4 / Leaving:0 / Exiting:0 / Joining:0 / Down:0

Pendingが -- になっていればノード追加は完了です。
