#!/bin/bash

cd ~

apt-get update
apt-get install -y fish locales

# fisherでoh-my-fishをインストール
# fisher installがttyがない場合は標準入力を待つようなので、インストール対象をパイプで渡す。
fish -c "curl -sL https://git.io/fisher | source && echo \"oh-my-fish/theme-bobthefish\" | fisher install"

# oh-my-fishの表示に必要なpowerlineのフォントをインストール
wget https://github.com/yuru7/HackGen/releases/download/v2.3.5/HackGenNerd_v2.3.5.zip -O HackGenNerd.zip
unzip HackGenNerd.zip
rm HackGenNerd.zip
mv ./HackGenNerd*/ /usr/local/share/fonts/HackGenNerd
fc-cache -fv

# 日本語のlocaleを作成
echo "ja_JP UTF-8" > /etc/locale.gen
locale-gen

# 追加の環境変数を設定
sed -i "2iexport LANG=ja_JP.UTF-8" ~/.profile
# fishの起動
echo "if [ -t 1 ]; then exec fish; fi" >> ~/.bashrc
