#!/bin/bash
# removes line breaks
# made with Sublist3r results in mind specifically
# tested on MacOS

sed -i '' 's/<BR>/\
/g' $1

sed -i '' 's/<br>/\
/g' $1

sed -i '' 's/<BR/>/\
/g' $1

sed -i '' 's/<br/>/\
/g' $1