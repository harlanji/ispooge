# iSpooge Live

A system for video websites and apps.

No centralization unless you want there to be.

Syndicate in common formats. Sites with the POSSE.

### Hosting

The site is built from the ground up to be static with progressive enhancement
on the client. It should be able to run offline, and also be enhanced by
the latest and greatest cloud services. Video can be hosted as an original file,
or transcoded for adaptive web and mobile playback. 

It was built on a RasPi to be as constrained an accessible as possible, and to
demononstrate the Tiny DataCenter project in action. It could be ported to run
on any static web host; current deployment model is a simple Docker container
that serves HTTP and static content.

### Social Discovery

It's 2018... people can discover your website via word of mouth, ping of text,
and RSS aggregators.

Each site has `/feed.xml` which is an RSS feed of the latest items. In the 
`config.edn` file for the project, one can simply add tags to a list like
`:rss-filters ["ispooge" "video"]` and then `/ispooge.xml` and `/video.xml`
will be exposed with those items filtered.

### Feedback

Out of the box, feedback is solicited via Email and Phone number. Those enable
a person to get started right away, without setting up IT systems or being 
concerned with moderation. Many YouTube Live and Twitch channels are based around
live feedback, so that could very easily become a priority.


### Scalability

Marketing can happen as normal. Being that the mechanics of decentralization are 
different, the marketing channels and metrics will be different. 

The IT scales by separating read and write paths intelligently, with read cache
tunable at several levels, and scaling out of the box via CDN.


## Usage

Scripts are mostly named with verbs and nouns. Eg. if you `scripts/start-A.sh` there will be
a `scripts/stop-A.sh`.

From a high level, the site needs to be build with Cryogen before anything can
be served. Once it's built, it needs to go into a static container. Around that
static container goes the streaming container... in techno babel, the streaming
container proxies to the static container.

Media is served from the static container. Dev is currently possible without starting
the streaming container, but it's so cheap you should. This will very likely soon
change as more rules are added to the `nginx.conf` file.

Note that we've not taken care to run multiple sites on one box yet... in theory
just a few changes need to be made around mapping resources. It should be possible
without much trouble.

The example only uses the 360p stream, but you can extrapolate the others. The 
config is set to take any number; by convention I end it with `_size`. Adaptive
playback is set for 360, 720, 240 in `nginx.conf`.

### Building

* `scripts/start-build.sh` - starts the Cryogen builder process

### Serving

* `scripts/build-static.sh` - builds a snapshot from what Cryogen has built
* `scripts/start-static.sh` - starts the snapshot that was built

* `scripts/build-streaming.sh` - builds the live video streaming server
* `scripts/start-streaming.sh` - starts the live streamig server we just built

### Accessing

Connect to `http://$HOST:33936/` and browse to `Live` on the menu bar, or go direct
to `http://$HOST:33936/live-360p.html`.

### Publishing

Publish an RTMP stream such as OBS or a webcam to `rtmp://$HOST:33935/ispoogedaily_local/ispoogedaily_360`.

For the best results, you should use the transcoding options available... to do this
you publish instead to `rtmp://$HOST:33935/ispoogedaily_source/ispoogedaily_360` and then run the
transcoding script `scripts/transcode-stream-360p.sh`. This script is optimized for
RasPi3's H264 accelerated hardware.

### Syndicating

Copy the RTMP stream you wish to syndicate upstream... usually the highest quality
variant:

* `ffmpeg -i rtmp://$HOST:33935/ispoogedaily_local/ispoogedaily_720 -c copy -f flv rtmp://_____`

