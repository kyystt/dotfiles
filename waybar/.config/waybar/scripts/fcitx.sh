#!/bin/bash

NAME=$(fcitx5-remote -n)

case $NAME in
    "keyboard-us")
        echo "US"
        ;;
    "keyboard-us-alt-intl")
        echo "US Intl"
        ;;
    "pinyin")
        echo "拼"
        ;;
    "m17n_zh_pinyin")
        echo "Pinyin"
        ;;
    *)
        echo "$NAME"
        ;;
esac

