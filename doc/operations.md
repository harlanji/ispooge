# Vodcast Origin Operations


These are literal instructions, in time difficult parts can be replaced with scripts.

It's worth understanding each of these commands, tho, and examining the script 
by using `cat scripts/thescript.sh` before running it... it should be understood before too long.

## Add a page

Assume you want to create a page A from the `ispooge.com-v2` directory.

* `touch md-pages/A.md`
* Edit the page with your editor... `nano` in CLI, `Bluefish` in X.

From here we can fall back to Cryogen documentation.


## Create a new playlist

Playlists are created in two parts. The playlist-Random post and optionally by the video post having 
the playlist-Random tag combined with a filter of same name in config.edn--creating a filtered playlist for rss readers.

```text

+- md
   +- posts
      +- DATE-video-TITLE-ID.md
      +- DATE-playlist-NAME.md
   videos
   +- TITLE-ID.mp4
   playlists
   +- NAME-ID.json

```

From here, these are just pages.


## Create a new video

Creating a new video is accomplished by copying it and a cover image to the `$ISPOOGE_MEDIA/videos`
directory and running the following scripts from the `ispooge.com-v2` directory.

Assuming you have files `MyVideo.mp4` and `MyVideo.jpg`:

* `mkdir A.hls` - directories can end in dot extensions, no worries
* `cd A.hls`
* `../../../tinydatacenter/ispooge.com-v2/scripts/segment-video.sh ../A.mp4` - will take time relative to length of video
* `ls -la` - you should see `out.m3u8` and `out0.ts` listed.
* `cd ../../../tinydatacenter/ispooge.com-v2`
* `scripts/make-video-page.sh A > md-pages/video-A.md`

The video page has in the EDN header

```clojure
{:layout :video
 :tags ["video" "playlist-Random"]
}
```


That's it... see the `Add a page` section for more details.

## Import a video from YouTube

Importing a video from YouTube is accomplished by using a tool to download the video
file and a thumbnail. Currently it's done at the Playlist level and downloads all videos.
Starting in the `ispooge.com-v2` directory:

* `cd $ISPOOGE_MEDIA/videos`
* `scripts/../../../tinydatacenter/ispooge.com-v2/scripts/download-video.sh VideoId`
* `ls -l` -- note the name of the file, `Title_of_Video-VideoId.mp4`
* Follow the steps from to in `Create a video` for the rest.


## Start a live stream

Assuming you are familiar with LiveStreaming to YouTube or Twitch and use OBS, 
this setup should be pretty familiar. As of now the archiving and posting does not
happen manually, but can be accomplished by recorded within OBS and following the 
process to create a new video.

If you are doing a simple local stream, you configure OBS to push to the URL

    rtmp://$RASPI_IP/ispoogedaily_local` with sream key `ispoogedaily`.

## Relay a live stream to YouTube, Twitch, FB Live, Periscope, etc

This is a one time setup for YouTube Live in the simplest case, or can be changed before
a broadcast to change providers or use the Event system with a custom stream key for the event.
From the `ispooge.com-v2` directory:

* `cd ../rtmp-proxy-docker`
* Edit `nginx.conf` to include your credentials in the `ispoogedaily_live` section, configuring desired upstream providers.
* `./build.sh`
* `./stop-proxy.sh ; ./start-proxy.sh` to restart the proxy with new config
* Ensure that OBS is pushing to `ispoogedaily_live`.

## Use RasPi OMX Hardware Transcoding

You can safely run multiple transcoding streams via the OMX hardware. I use three
and am experimenting with the best settings. Using a custom compiled ffmpeg
you can get substantial speedups in video processing.

