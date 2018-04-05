{:title "Hacking"
 :tags ["video" "live" "hacking"]
 :layout :video
 :video-yt-id "LqE5wL6sUmY"
 :video-yt-additional-ids []
 :video-description "Tour of SwEng chart changes, ideas. Thoughts about pre-flight ops: notes split into headsup, ideas, todo; live."
}



## Log


0:00 Setup

10:00 Preflight

daily broadcasting steps:

- start up streaming software
- set metadata on syndicates: twitch, youtube
- start streaming
- create event page on site from template
- add YT video id


livestremaing shows, preflight:

- hammock driven develop new ideas
- iterate over yesterday's notes
- come up with new priorities

14:00


48:45 thumbsup because we moved the video in the fresh page. last ~20 min were that

In the markdown place a header `# WHATS ISPOOGE LIVE VIDEO`; ID is derived from title.

```
  var el = document.getElementById('whats_ispooge_live_video');
  var newEl = document.getElementById('whats-ispooge-live-video-yt');
  
  el.parentElement.replaceChild(newEl, el);
```

56:00 works, confirmed... maybe forgot to remove function declaration before getting excited



1:00 centering video... 

"what's ispooge live?" should be self hosted... do transcode

1:17 - deployed updated version


## Notes



### ideas

monetization
  - emails/calls
  - payment/tip integration
    - we have steemit--produce work for it
    - GNU Taler for cash+anon
- rss reader app
- writing
  - presentation updates
    - [x] link what's ispooge live video
    - [ ] transcode video for self host
  - daily broadcasting ops
  - ux tweets from screenshots
- videojs r&d
  - commercial spots
  - annotated comments




### todo



## Links


* [https://developer.mozilla.org/en-US/docs/Web/API/Node/replaceChild](https://developer.mozilla.org/en-US/docs/Web/API/Node/replaceChild)


