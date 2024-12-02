#!/bin/sh
TEMP=$(mktemp)

cleanup() {
    [ -n "$NULL_SINK_MODULE" ] && pactl unload-module "$NULL_SINK_MODULE" 2>/dev/null
    [ -n "$REMAP_SOURCE_MODULE" ] && pactl unload-module "$REMAP_SOURCE_MODULE" 2>/dev/null
    rm -f "${TEMP}"
}
trap cleanup EXIT

# Load PulseAudio modules and capture their indices
[ -x "$(command -v pactl)" ] || {
    echo "This script version needs PulseAudio."
    exit 1
}
NULL_SINK_MODULE=$(pactl load-module module-null-sink sink_name=voicechanger-tui_out sink_properties=device.description="Thank_Poetteringware_for_this_🙇voicechanger-tui")
REMAP_SOURCE_MODULE=$(pactl load-module module-remap-source source_name=voicechanger-tui_in master=voicechanger-tui_out.monitor source_properties=device.description="voicechanger-tui")
[ -z "$NULL_SINK_MODULE" ] || [ -z "$REMAP_SOURCE_MODULE" ] && {
    echo "Failed to load PulseAudio modules."
    exit 1
}

# Voice changer logic
while sleep 1;do tput sc;tput cup 0 0;cat "${TEMP}" | tail -n1;tput rc;done &
while true
do
    VOICE=$(dialog --title "Voice list" --stdout --no-ok --no-cancel --no-tags --item-help --menu "Select which voice modification you want to use." 0 0 0 \
    "pitch 700 contrast 100 echo 0 1 20 0.4" "child" "sox -t pulseaudio default -t pulseaudio voicechanger-tui_out pitch 700 contrast 100 echo 0 1 20 0.4" \
    "pitch -200 contrast 100 echo 0 1 20 0.4" "young adult" "sox -t pulseaudio default -t pulseaudio voicechanger-tui_out pitch -200 contrast 100 echo 0 1 20 0.4" \
    "pitch -500 contrast 100 echo 0 1 20 0.4" "old man" "sox -t pulseaudio default -t pulseaudio voicechanger-tui_out pitch -500 contrast 100 echo 0 1 20 0.4" \
    )
    kill $APP_PID
    sox -t pulseaudio default -t pulseaudio voicechanger-tui_out $VOICE 1>/dev/null 2>"${TEMP}" & export APP_PID=$!
done
