#!/bin/bash

# https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/StreamingMediaGuide/UsingHTTPLiveStreaming/UsingHTTPLiveStreaming.html

# https://docs.peer5.com/guides/production-ready-hls-vod/

# http://www.bogotobogo.com/VideoStreaming/ffmpeg_http_live_streaming_hls.php

# https://www.encoding.com/blog/2014/02/24/simplify-http-live-streaming-encoding-com-hls-segmenter/


# detailed example of ffmpeg cli options: https://forums.roku.com/viewtopic.php?t=60698

# details of GOP params: https://superuser.com/questions/908280/what-is-the-correct-way-to-fix-keyframes-in-ffmpeg-for-dash


# example ffmpeg for multi-transcoding: https://blog.twitch.tv/live-video-transmuxing-transcoding-ffmpeg-vs-twitchtranscoder-part-i-489c1c125f28

# http://www.streamingmedia.com/Articles/ReadArticle.aspx?ArticleID=95251&PageNum=3

# Tinkerboard (decoders only): https://tinkerboarding.co.uk/forum/archive/index.php/thread-51.html


# adding hls to ffmpeg: 
# https://trac.ffmpeg.org/ticket/1642 
# https://trac.ffmpeg.org/ticket/1642

# https://trac.ffmpeg.org/wiki/EncodingForStreamingSites

# rpi omx:  https://signal-flag-z.blogspot.com/2017/05/raspberry-pix264ffmpeg.html

VIDEO_PATH="$1"

VIDEO_PATH_PREFIX=$(echo "$VIDEO_PATH" | cut -f 1 -d '.')
PLAYLIST_PATH="$VIDEO_PATH_PREFIX.m3u8"

avconv \
  -i $VIDEO_PATH \
   -c copy \
   -flags \
     +cgop \
     -g 30 \
     -hls_time 2 \
     -hls_list_size 100000 \
     -bsf h264_mp4toannexb \
   $PLAYLIST_PATH
