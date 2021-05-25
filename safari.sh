#!/bin/zsh
# Fix Safari Favorites Icons

DIR="$HOME/Library/Safari/Touch Icons Cache/Images"

CS="cache_settings"
DB="$DIR/../TouchIconCacheSettings.db"
sqlite3 "$DB" "UPDATE $CS SET icon_is_in_cache=1, download_status_flags=1"

for png in "$1"/*.png
do 
	BASENAME=`basename ${png%.png}`
	URL="$(plutil -convert xml1 -o - "$DIR/../../Bookmarks.plist" | awk -F '[</>]' -v name="$BASENAME" '$3~name{getline;getline;getline;print $5}' | head -n 1)"
	cp -f -v "$png" "$DIR/${(U)$(md5 -q -s $URL)}.png"
done

chflags -v uappnd $DIR $DB