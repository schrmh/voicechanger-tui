#!/bin/sh
TEMP=$(mktemp)
while sleep 1;do tput sc;tput cup 0 0;cat "${TEMP}" | tail -n1;tput rc;done &
while true
do
    VOICE=$(dialog --title "Voice list" --stdout --no-ok --no-cancel --no-tags --item-help --menu "Select which voice modification you want to use." 0 0 0 \
    "-d -d pitch 700 contrast 100 echo 0 1 20 0.4" "child" "sox -d -d pitch 700 contrast 100 echo 0 1 20 0.4" \
    "-d -d pitch -200 contrast 100 echo 0 1 20 0.4" "young adult" "sox -d -d pitch -200 contrast 100 echo 0 1 20 0.4" \
    "-d -d pitch -500 contrast 100 echo 0 1 20 0.4" "old man" "sox -d -d pitch -500 contrast 100 echo 0 1 20 0.4" \
    )
    kill $APP_PID
    sox $VOICE 1>/dev/null 2>"${TEMP}" & export APP_PID=$! 
done
