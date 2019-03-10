# .bashrc

# Function part
## 16bitカラーの定義がわかりにくいので再定義(なくてもいいです)
c_red="\e[31m"
c_gre="\e[32m"
c_yel="\e[33m"
c_blu="\e[34m"
c_mag="\e[35m"
c_cya="\e[36m"
c_off="\e[m"

# Source global definitions
## おまじない
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Aliases
## この他にもよく使うコマンドのエイリアスを追加してもいいです。
alias grep='grep --color'

## Macでしか使えないコマンドはこのif文の中に入れるといいです
if [ "$(uname)" = "Darwin" ]; then
    alias ls='ls -FG'
    alias ll='ls -FGal'
## 逆にMac以外で有効にしたいものはこちらへ
else
    alias ls='ls -F --color=auto'
    alias ll='ls -Fal --color=auto'
fi

## 環境別設定
### 色の設定などは完全に好みです
### ログインした時点で、そのサーバーのhostnameを元に環境を判断し、shellの表示する文字を変更します
### if文の中の-eごとに部分一致の条件を付け加えられます

# 本番環境
if [ `hostname | grep -e "pro" -e "honban"| wc -l | tr -d " "` -eq 1 ] ; then
## 次の行でコンソールでカレントディレクトリの表示、コマンドごとに改行、色の定義を行う。
    PS1="\[\n${c_red}\]\D{%Y/%m/%d} \t \u@\h -> \[${c_yel}\]\n\w -> \n$ \[\e[0m\]"
# 検証環境
elif [ `hostname | grep -e "stg" | wc -l | tr -d " "` -eq 1 ] ; then
    PS1="\[\n${c_gre}\]\D{%Y/%m/%d} \t \u@\h -> \[${c_yel}\]\n\w -> \n$ \[\e[0m\]"
# ローカル環境
elif [ `hostname | grep -e "local" | wc -l | tr -d " "` -eq 1 ] ; then
    PS1="\[\n${c_cya}\]\D{%Y/%m/%d} \t \u@\h -> \[${c_yel}\]\n\w -> \n$ \[\e[0m\]"
# 自己開発用
elif [ `hostname | grep -e "exp" | wc -l | tr -d " "` -eq 1 ] ; then
    PS1="\[\n${c_mag}\]\D{%Y/%m/%d} \t \u@\h -> \[${c_yel}\]\n\w -> \n$ \[\e[0m\]"
else
## どの環境識別条件にも合わなかったら警告文を赤字で出します。
    printf "${c_red}*** It is an undefined environment***\n${c_off}"
fi

