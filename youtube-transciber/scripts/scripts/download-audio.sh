#!/bin/bash

VIDEO_ID=$1

[ -z "$VIDEO_ID" ] && echo "Usage: $0 <video_id>" && exit 1

# Use yt-dlp to get the best audio format available in M4A.
BEST_AUDIO_FORMAT=$(yt-dlp "https://www.youtube.com/watch?v=$VIDEO_ID" --list-formats | grep "audio only" | grep "m4a" | sort -k 4 -n | tail -n 1 | awk '{print $1}')

if [ -z "$BEST_AUDIO_FORMAT" ]; then
    echo "Error: Unable to find a suitable M4A audio format."
    exit 1
fi

# Download the audio in M4A format and save it to the specified directory.
yt-dlp "https://www.youtube.com/watch?v=$VIDEO_ID" -f $BEST_AUDIO_FORMAT -o "D:/Projects/translations/youtube-transciber/tmp/%(id)s.%(ext)s" 2>&1
