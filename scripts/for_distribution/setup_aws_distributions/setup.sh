#!/usr/bin/bash

# AWS系(AmazonLinuxなど)で「最初にやること」を記述したシェル
# 基本的には「どのディストリでも動く方法」をとるが、ディストリ特殊なものはコメントで書く。	

MY_USER=kazuhito
DEFAULT_USER=${USER}

GIT_USER=kazuhito-m

# ユーザを追加し、元のユーザを無効化する。

sudo useradd -m -s '/bin/bash' ${MY_USER}
sudo passwd ${MY_USER}
# グループに追加(これはUbuntu固有？)
for i in  sudo adm dialout cdrom floppy sudo audio dip video plugdev netdev ; do
  sudo gpasswd -a ${MY_USER} ${i}
done
# 鍵コピー
sudo mkdir /home/${MY_USER}/.ssh
sudo cp /home/${DEFAULT_USER}/.ssh/authorized_keys /home/${MY_USER}/.ssh/authorized_keys
sudo chmod 600 /home/${MY_USER}/.ssh/authorized_keys
sudo chown -R ${MY_USER}:${MY_USER} /home/${MY_USER}/.ssh

# git settings
# git config --global user.email "sumpic@hotmail.com"
# git config --global user.name "${GIT_USER}"

cat << _EOT_ > ./.netrc
machine github.com
login ${GIT_USER}
password xxxxxxxx
_EOT_
sudo mv ./.netrc /home/${MY_USER}/
sudo chown ${MY_USER}:${MY_USER} /home/${MY_USER}/.netrc

# ユーザをs削除する。
# sudo userdel -r ubuntu

# ココからは「Ubuntuかつデスクトップ運用したい場合」のみの設定。
# まずは「デスクトップを上げたいユーザでログインし、以下のコマンドを打つ。
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y gnome-core ubuntu-desktop tightvncserver 
# 初回、vncserverパスワード決め
vncserver :1
# すぐさま殺す
vncserver -kill :1
# ~/.vnc/xstartup 書き換え
mv ~/.vnc/xstartup ~/.vnc/xstartup.org
grep -v '^x-.*' ~/.vnc/xstartup.org > ~/.vnc/xstartup
cat << _EOS_ >>  ~/.vnc/xstartup
exec gnome-session &
gnome-panel &
gnome-settings-daemon &
metacity &
nautilus -n &
gnome-terminal &
_EOS_
chmod 755 ~/.vnc/xstartup
