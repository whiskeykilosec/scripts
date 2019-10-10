#!/bin/zsh
# Credit dardo82/safari-favicons.sh
# Fix Safari Favorites Icons

CS="cache_settings"; TIC="Touch Icons Cache"; DIR="$HOME/Library/Safari/$TIC/Images"
DB="$DIR/../${${TIC// }%%s*}${${(C)CS}//_}.db"; SQL=$(sqlite3 "$DB" "SELECT host FROM $CS")
sqlite3 "$DB" "UPDATE $CS SET ${${${(L)TIC// /_}#*_}//s/_is_in}=1, download_status_flags=1"
for png in "$1"/*.png; do URL="$(plutil -convert xml1 -o - "$DIR/../../Bookmarks.plist" | \
awk -F '[</>]' -v name="${${png##*/}%%.*}" '$3~name{getline;getline;getline;print $5}')"; \
cp -f -v "$png" "$DIR/${(U)$(md5 -q -s $URL)}.png"; done; chflags -v uappnd $DIR $DB
