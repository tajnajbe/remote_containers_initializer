#!/bin/bash

cd ~

echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_11/ /' | tee /etc/apt/sources.list.d/shells:fish:release:3.list
curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_11/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null
apt-get update
apt-get install -y fish locales nano

# fisherでoh-my-fishをインストール
# ttyがない場合はfisher installは標準入力を待つようなので、インストール対象をパイプで渡す。
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && echo \"oh-my-fish/theme-bobthefish\" | fisher install"

# oh-my-fishの表示に必要なpowerlineのフォントをインストール
wget https://github.com/yuru7/HackGen/releases/download/v2.10.0/HackGen_NF_v2.10.0.zip -O HackGen_NF.zip
unzip HackGen_NF.zip
rm Hac`kGen_NF.zip
mv ./HackGen_NF*/ /usr/local/share/fonts/HackGen_NF
fc-cache -fv

# 日本語のlocaleを作成
echo "ja_JP UTF-8" > /etc/locale.gen
locale-gen

# 追加の環境変数を設定
sed -i "2iexport LANG=ja_JP.UTF-8" ~/.profile
# fishの起動
echo "if [ -t 1 ]; then exec fish; fi" >> ~/.bashrc
