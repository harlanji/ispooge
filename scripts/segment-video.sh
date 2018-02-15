#!/bin/bash

avconv -i $1 -c copy -flags +cgop -g 30 -hls_time 2 -hls_list_size 100000 -bsf h264_mp4toannexb out.m3u8
