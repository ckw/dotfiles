#! /usr/bin/env sh
echo $(grep -v "'" /usr/share/dict/words | gshuf -n5 | paste -s -d'-' -)
