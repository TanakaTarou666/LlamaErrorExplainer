# Llamaでエラーメッセージを解説させる導入手順
## 注意事項
今回の手順では、Pythonを用いてテストを行います。なお、`~/.bashrc`を書き換えることで、他の環境でも同様の対応が可能です。

## 動作環境
windows 10

## 事前準備
以下から `ELYZA-japanese-Llama-2-7b-instruct-q4_K_M.gguf` を `/env` にダウンロードしてください。

- [ELYZA Japanese Llama 2 7b Instruct](https://huggingface.co/mmnga/ELYZA-japanese-Llama-2-7b-instruct-gguf/blob/main/ELYZA-japanese-Llama-2-7b-instruct-q4_K_M.gguf)

## ターミナル操作

```bash
# 作業ディレクトリへ移動
$ cd env

# Dockerイメージのビルド
$ docker build -t myllama:1.0 .

# Dockerコンテナの起動
$ docker run -it --name llama_con -v D:/gitproject/LlamaErrorExplainer:/home/llama -d myllama:1.0

# コンテナに入る
# ※2つのターミナルを開いて２つのコンテナに入る
$ docker exec -it llama_con bash
```

## コンテナ1
以下でllamaのserverを立てる。
```
$ curl -fsSL https://ollama.com/install.sh | sh
$ ollama serve
```

## コンテナ2
### 1. モデルの導入
```
# 作業ディレクトリへ移動
$ cd /home/llama/env

# モデルの作成
$ ollama create elyza:7b-instruct -f Modelfile
```
以下が実行できればllamaの導入成功
```
$ ollama run elyza:7b-instruct
>>> Send a message (/? for help)
```
llamaの終了は以下
```
>>> /bye 
```
### 2. `.bashrc`の編集
次に、以下を実行し、`vi` コマンドで `.bashrc` に関数を追加し、更新します。
```
$ vi ~/.bashrc
```
追加する内容：
```
function ee(){
        bash ~/explain_error.bash
}

function pythonl(){
        python3 "$@" 2> >(tee ~/log.txt)
}
```
以下で変更を反映させる。
```
$ source ~/.bashrc
```

###  3. `explain_error.bash`の追加
以下で`explain_error.bash`を`~/`に配置する。
```
$ cp ../scripts/explain_error.bash ~/
```
作業は終了。

## テスト実行
以下で`/scripts/test/`のディレクトリに移動しテストを実行します。
```
$ cd ../scripts/test
$ pythonl test.py
$ ee
```

## Extend
`/scripts/extension`に書き換えることでファイルの読み込みも可能。(精度は未知数)
以下が実行コマンド
```
$ pythonl test.py
$ ee test.py test2.py ...
```

