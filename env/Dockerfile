# docker exec -it llama_con bash
# ベースイメージをUbuntuに指定
FROM ubuntu:22.04

# 必要なパッケージのインストール
RUN apt-get update && \
    apt-get install -y \
        apt-utils \
        curl \
        vim \
        python3 \
        python3-pip \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
# 作業ディレクトリの設定
WORKDIR /home

# コンテナ起動時に実行されるコマンド
CMD ["bash"]
