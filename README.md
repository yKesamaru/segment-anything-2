# `segment-anything-2`を試す

## はじめに
Metaは2024年7月29日に、`Segment Anything Model 2`を発表しました。

Introducing Meta Segment Anything Model 2 (SAM 2)
https://ai.meta.com/sam2/

ここでは公式GitHubに用意されているノートブックのうち、画像内の自動マスク生成を試したいので、`Automatically generating object masks with SAM`を参考にします。

以下の画像は出力の一例です。

![](assets/eye-catch.png)


## 環境
```bash
$ inxi -SGxxx --filter
System:
  Kernel: 6.5.0-45-generic x86_64 bits: 64 compiler: N/A Desktop: Unity
    wm: gnome-shell dm: GDM3 42.0 Distro: Ubuntu 22.04.4 LTS (Jammy Jellyfish)
Graphics:
  Device-1: NVIDIA TU116 [GeForce GTX 1660 Ti] vendor: Micro-Star MSI
    driver: nvidia v: 555.42.06 pcie: speed: 2.5 GT/s lanes: 16 ports:
    active: none off: HDMI-A-1 empty: DP-1,DVI-D-1 bus-ID: 09:00.0
    chip-ID: 10de:2182 class-ID: 0300
  Display: x11 server: X.Org v: 1.21.1.4 compositor: gnome-shell driver: X:
    loaded: nvidia unloaded: fbdev,modesetting,nouveau,vesa gpu: nvidia
    display-ID: :1 screens: 1
  Screen-1: 0 s-res: 2560x1440 s-dpi: 122 s-size: 533x290mm (21.0x11.4")
    s-diag: 607mm (23.9")
  Monitor-1: HDMI-0 res: 2560x1440 hz: 60 dpi: 123
    size: 527x296mm (20.7x11.7") diag: 604mm (23.8")
  OpenGL: renderer: NVIDIA GeForce GTX 1660 Ti/PCIe/SSE2
    v: 4.6.0 NVIDIA 555.42.06 direct render: Yes
```

## GPUについて
このノートブックを試用するには`Ampare`アーキテクチャ、`Compute Capability`が`8.0`以降のGPUが推奨されます。

ご自身のGPUを調べたいときは以下の記事を参考にしてください。

- アーキテクチャを調べるには

  https://tokai-kaoninsho.com/face-recognition-software/%e7%92%b0%e5%a2%83%e6%a7%8b%e7%af%89-face-recognition-software/gpu%e5%b0%8e%e5%85%a5/

例えばわたしの場合、`segment-anything-2`プロジェクト内の`transformer.py`22行目で以下の警告が出力されました。
```bash
/home/terms/ドキュメント/segment-anything-2/segment-anything-2/sam2/modeling/sam/transformer.py:22: UserWarning: Flash Attention is disabled as it requires a GPU with Ampere (8.0) CUDA capability.
  OLD_GPU, USE_FLASH_ATTN, MATH_KERNEL_ON = get_sdpa_settings()
```
`Flash Attention`が無効化される旨が出力されています。`Transformerモデル`の高速化技術が無効化されます。
わたしのGPUは先述の環境の項で記述しましたが、`Turing`世代で`Compute Capability`が`7.5`です。
学習モデルを変更することで、なんとか画像だけは出力が出来ました。

## インストール手順
インストールは[GitHubの公式ページ](https://github.com/facebookresearch/segment-anything-2?tab=readme-ov-file#installation)を参考に行います。

### インストールの様子
https://github.com/yKesamaru/segment-anything-2/blob/8ea108d1ae894c1e6b6d10dca582b0c5b1bf69b8/how_itis_installed.sh#L1-L63

ダウンロードされたモデル群

![](assets/2024-08-05-15-45-46.png)

モデルの大きさは以下の通り。
```bash
ls -lh | awk '{print $9, $5}'

sam2_hiera_base_plus.pt 309M
sam2_hiera_large.pt 857M
sam2_hiera_small.pt 176M
sam2_hiera_tiny.pt 149M

```

> ![NOTE]
> 後のノートブック実行の際、`matplotlib`, `cv2`がインストールされていないとエラーが発生しますので、`matplotlib`をインストールしておきます。
> 
> ```
> (.venv) user@user:~/ドキュメント/segment-anything-2/segment-anything-2$ pip install matplotlib opencv-python
> ```

## `Automatically generating object masks with SAM`
ここでは`画像内の自動マスク生成`を試したいので、[`Automatically generating object masks with SAM`](https://github.com/facebookresearch/segment-anything-2/blob/main/notebooks/automatic_mask_generator_example.ipynb)を参考にします。

> (自動翻訳)
> SAM によるオブジェクト マスクの自動生成
> 
> SAM 2 はプロンプトを効率的に処理できるため、画像上で多数のプロンプトをサンプリングすることで画像全体のマスクを生成できます。
> 
> SAM2AutomaticMaskGenerator クラスはこの機能を実装します。これは、画像上のグリッド内の単一点入力プロンプトをサンプリングすることによって機能し、SAM はそれぞれのプロンプトから複数のマスクを予測できます。
> 次に、マスクは品質のためにフィルタリングされ、非最大抑制を使用して重複が排除されます。
> 追加のオプションにより、画像の複数のクロップに対して予測を実行したり、マスクの後処理を行って小さな切断された領域や穴を除去したりするなど、マスクの品質と量をさらに向上させることができます。


### コード変更箇所
#### 処理画像の差し替え
```diff: In [17]
- image = Image.open('images/cars.jpg')
+ image = Image.open('images/people_1.png')
```
#### 使用モデルの差し替え
ビデオメモリが足りないため。
```diff: In [19]
- sam2_checkpoint = "../checkpoints/sam2_hiera_large.pt"
+ sam2_checkpoint = "../checkpoints/sam2_hiera_tiny.pt"
- model_cfg = "sam2_hiera_l.yaml"
+ model_cfg = "sam2_hiera_t.yaml"
```

## 実行結果
- 元画像

- 処理後の画像


## 最後に
使用したGPUのメモリ搭載量の少なさや`Compute Capability`の低さによって制限はありましたが、`segment-anything-2`の感触はつかめました。
本来であればリアルタイムの動画に対してセグメンテーションを実行することが可能なので、良いGPUをお持ちの方は試してみられると良いと思います。ローカル環境を構築するのに難しいところはありません。

本来であれば[Web上でデモ](https://sam2.metademolab.com/?utm_source=ai_meta_site&utm_medium=web&utm_content=AI_demos_page&utm_campaign=July_moment)が使用できるはずですが、わたしの場合、`Firefox`, `Chrome`どちらで試してもWebのデモが実行できませんでした。

以上です。ありがとうございました。

## 参考文献
- [SAM 2: Segment Anything in Images and Videos](https://github.com/facebookresearch/segment-anything-2?tab=readme-ov-file)