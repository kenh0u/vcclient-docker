# vcclient-docker
VC Client([w-okada/voice-changer](https://github.com/w-okada/voice-changer))をDockerで手軽に実行するためのDockerfileとシェルスクリプト

## Description

最新のVC ClientをDockerで手軽かつ綺麗に使えます。

[w-okada/voice-changerのREADME_dev_ja.md](https://github.com/w-okada/voice-changer/blob/master/README_dev_ja.md)
の環境構築手順に準じてDockerfileを記述しました。

## Requirements

 - Linux or WSL2
 - Docker

## Usage

### Build docker image (first time only)

Dockerfileのベースイメージ(ubuntu:20.04)は各々の環境の都合に合わせて書き換えるといいでしょう。

Python環境にAnacondaを使用しているので、Ubuntuであれば違うバージョンでもそのまま動く可能性が高いと思われます。

```
git clone https://github.com/kenh0u/vcclient-docker.git
cd vcclient-docker
./build.sh
```

### Run

```
./run.sh
```

コマンドオプションでポートを指定することもできます。(無指定時は18888)

```
./run.sh -p 18888
```

初回起動時、`pretrain`,`models`ディレクトリに自動でいろいろダウンロードされると思うので、各利用規約を遵守してください。

Webブラウザで [https://localhost:18888](https://localhost:18888) (ポートを指定した場合は、そのポート)にアクセスすることで使用できます。

終了時はターミナルで`Ctrl-C`を押してください。

## Tested Environment

|Distribution|Ubuntu 20.04.3           |
|:----------:|:-----------------------:|
|Kernel      |5.4.0-81-generic         |
|CUDA        |11.4                     |
|Docker      |20.10.7                  |
|CPU         |Intel Xeon E5-2698 v4    |
|RAM         |512GB                    |
|GPU         |8x NVIDIA Tesla V100 32GB|
