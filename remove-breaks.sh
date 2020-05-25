#!/bin/bash
# removes Sublist3r line break tags
# tested on MacOS, which doesn't respect \n. Need an actual new line preceded by a backslash
# backup your file. -i will overwrite the source

sed -i '' 's/<BR>/\
/g' $1

sed -i '' 's/<br>/\
/g' $1

sed -i '' 's/<BR/>/\
/g' $1

sed -i '' 's/<br/>/\
/g' $1