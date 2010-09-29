#!/bin/bash
#set -x
cat - | {
nt_icon="gtk-dialog-info"
nt_time=5000
nt_head="Notify"
nt_text="Error Occured"
nt_type="Message"
while read k v
do
case $k in
TYPE) nt_type="$v";;
ICON) nt_icon="$v";;
CONTENT) nt_text="$v"; notify-send -i "$nt_icon" -c "$nt_type" -t "$nt_time" -- "$nt_head" "$nt_text"
;;
TIMEOUT) nt_time="$v";;
#SHOWFOR) nt_time="$v";;
SUBJECT) nt_head="$v";;
*) ;;
esac
#echo "$k: $v";
done
echo "=== END ==="
notify-send -i "$nt_icon" -c "$nt_type" -t "$nt_time" -- "$nt_head" "$nt_text"
}