#!/bin/bash

cd ~

echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_10/ /' | tee /etc/apt/sources.list.d/shells:fish:release:3.list
curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_10/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null
apt-get update
apt-get install -y fish locales nano

# fisherでoh-my-fishをインストール
# ttyがない場合はfisher installは標準入力を待つようなので、インストール対象をパイプで渡す。
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && echo \"oh-my-fish/theme-bobthefish\" | fisher install"

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
