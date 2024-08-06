user@user:~/ドキュメント/ mkdir segment-anything-2

user@user:~/ドキュメント/ cd segment-anything-2

user@user:~/ドキュメント/segment-anything-2$ git clone https://github.com/facebookresearch/segment-anything-2.git
Cloning into 'segment-anything-2'...
remote: Enumerating objects: 320, done.
remote: Counting objects: 100% (49/49), done.
remote: Compressing objects: 100% (36/36), done.
remote: Total 320 (delta 20), reused 13 (delta 13), pack-reused 271
Receiving objects: 100% (320/320), 42.93 MiB | 10.95 MiB/s, done.
Resolving deltas: 100% (27/27), done.

user@user:~/ドキュメント/segment-anything-2/segment-anything-2$ python  -V
Python 3.10.12

# 仮想環境を構築
user@user:~/ドキュメント/segment-anything-2/segment-anything-2$ python -m venv .venv

user@user:~/ドキュメント/segment-anything-2/segment-anything-2$ . .venv/bin/activate

(.venv) user@user:~/ドキュメント/segment-anything-2/segment-anything-2$ pip install -U pip setuptools wheel
Requirement already satisfied: pip in ./.venv/lib/python3.10/site-packages (22.0.2)
Collecting pip
  Downloading pip-24.2-py3-none-any.whl (1.8 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.8/1.8 MB 8.9 MB/s eta 0:00:00
Requirement already satisfied: setuptools in ./.venv/lib/python3.10/site-packages (59.6.0)
Collecting setuptools
  Downloading setuptools-72.1.0-py3-none-any.whl (2.3 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 2.3/2.3 MB 10.7 MB/s eta 0:00:00
Collecting wheel
  Downloading wheel-0.44.0-py3-none-any.whl (67 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 67.1/67.1 KB 11.1 MB/s eta 0:00:00
Installing collected packages: wheel, setuptools, pip
  Attempting uninstall: setuptools
    Found existing installation: setuptools 59.6.0
    Uninstalling setuptools-59.6.0:
      Successfully uninstalled setuptools-59.6.0
  Attempting uninstall: pip
    Found existing installation: pip 22.0.2
    Uninstalling pip-22.0.2:
      Successfully uninstalled pip-22.0.2
Successfully installed pip-24.2 setuptools-72.1.0 wheel-0.44.0

(.venv) user@user:~/ドキュメント/segment-anything-2/segment-anything-2$ pip install -e  .
# (省略)

(.venv) user@user:~/ドキュメント/segment-anything-2/segment-anything-2$ cd checkpoints/


# `download_ckpts.sh`を実行してモデルをダウンロードする
(.venv) user@user:~/ドキュメント/segment-anything-2/segment-anything-2/checkpoints$ ./download_ckpts.sh 
Downloading sam2_hiera_tiny.pt checkpoint...
--2024-08-05 15:34:58--  https://dl.fbaipublicfiles.com/segment_anything_2/072824/sam2_hiera_tiny.pt
dl.fbaipublicfiles.com (dl.fbaipublicfiles.com) をDNSに問いあわせています... 54.239.168.70, 54.239.168.51, 54.239.168.2, ...
dl.fbaipublicfiles.com (dl.fbaipublicfiles.com)|54.239.168.70|:443 に接続しています... 接続しました。
HTTP による接続要求を送信しました、応答を待っています... 200 OK
長さ: 155906050 (149M) [application/vnd.snesdev-page-table]
‘sam2_hiera_tiny.pt’ に保存中

sam2_hiera_tiny.pt                            46%[=========================================>                                                  ]  69.30M  11.2MB/s    eta 7s     

# (省略)