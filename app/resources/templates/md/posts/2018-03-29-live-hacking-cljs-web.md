{:title "Live Hacking Cljs Web" 
 :tags ["video" "live"]
 :layout :video
 :video-yt-id "_UyL81wbxck"
 :video-yt-additional-ids [] ; TODO, add to template.
 :video-description "Live Hacking Reagent - Web Tech"
}



### Notes

CLJS date parsing behavior with edge case inputs:

```
dev:uspooge-app.core=> (new js/Date nil)
#inst "1970-01-01T00:00:00.000-00:00"
dev:uspooge-app.core=> (new js/Date "")
#inst "NaN-NaN-NaNTNaN:NaN:NaN.NaN-00:00"
dev:uspooge-app.core=> (new js/Date)
#inst "2018-03-29T18:35:28.244-00:00"
dev:uspooge-app.core=> (new js/Date 0)
#inst "1970-01-01T00:00:00.000-00:00"
```


#### Scripting a table in Cryogen

Table can be found by iterating siblings from a known header. This is true as of 
`[markdown-clj ""]`. 

```
function paintItBlack () {
  var el = document.getElementById('roles_by_project');
  while( el && el.nodeName.toLowerCase() != 'table') {
    el = el.nextSibling;
    console.log('next');
  }
  if (el) {
    el.style.backgroundColor = 'black';
    el.style.color = 'red';
  }
}
```

Run from console via `paintItBlack()` or via pasting `javascript:paintItBlack()` in the address bar and navigating.


Can be made general by giving an ID and using CSS.


Interesting selector: `document.querySelector('#roles_by_project + table')`

* https://css-tricks.com/child-and-sibling-selectors/

* https://kimblim.dk/css-tests/selectors/examples/preceding.html




### Links

* [Yesterday's Stream](/2018-03-28-live-hacking-reagent.html)
* [http://www.pyco.me/import-clojurescript-into-es6-module/](http://www.pyco.me/import-clojurescript-into-es6-module/))
* [http://javajdk.net/tutorial/calling-clojurescript-from-javascript/](http://javajdk.net/tutorial/calling-clojurescript-from-javascript/)
* [shadow-cljs](http://shadow-cljs.org/)





