#!/bin/zsh

# Credit dardo82/safari-favicons.sh
# Fix Safari Missing Touch Favicons

HLSD="$HOME/Library/Safari"; SCD="$HLSD/Touch Icons Cache/Images"

typeset -A BMA; BMA=($(plutil -p "$HLSD/Bookmarks.plist" \
| sed -n '/title/{h;n;n;H;x;p'$'\n''}' \
| awk -F'"' '{name=$4; getline; if($0~/\"[a-z]+:\/\//){print name" "$4}}'))

for bmn in ${(k)BMA[@]}; do
cp -v "$1/$bmn.png" "$SCD/${(U)$(md5 -qs ${${${BMA[$bmn]}#*//}%%/*})}.png"; done
