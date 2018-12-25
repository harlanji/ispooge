(ns uspooge-app.core
  (:require-macros [cljs.core.async.macros :refer [go]])

  (:require [clojure.string :as str]
            [reagent.core :as r]
            [cljs-http.client :as http]
            [cljs.core.async :as async :refer [<!]]
            [baking-soda.core :as b]))

(enable-console-print!)

(defonce feeds (r/atom []))
(defonce active-user (r/atom {:name "Anonymous CoW"}))
(defonce app-state (r/atom {:text "Hello clojure world!" :nav-open? true :dropdown-open? false :__figwheel_counter 0 :active-user active-user}))

(println "h      i")

(defn item-is-yt? [item]
  (not (nil? (:yt-id item))))

(defn item-is-video? [item]
  (not (nil? (:media item))))

(defn video-items [items]
  (filter #(or (item-is-video? %) (item-is-yt? %)) items))

(declare video-item)

(defn yt-item [item]
  [:div {} [:iframe.feed-video {:src (str "https://www.youtube-nocookie.com/embed/" (:yt-id item) "?rel=0&amp;showinfo=0")
                                :frameborder "0"
                                :allow "autoplay; encrypted-media"
                                :allowfullscreen "allowfullscreen"}]])

; [:a {:href (:url item)} [:p (:title item)]]

(defn feed-items [items]
  [:ul
   (for [item items]
     [:li.feed-item
      [:div {} (if (item-is-video? item)
                 (video-item item)
                 (when (item-is-yt? item)
                   (yt-item item)))]
               [:p
                 [:a {:href (:url item)} (:title item)]
                 " "
                 (:feed-title item)]
               [:p (str (:pub-date item))] ; TODO format date, shrink line height and font
               
               ])])

(defn iframe-video-item [item]
  (let [media (:media item)]
    [:iframe.feed-video {:src (:url media)}]))

(defn video-item [item]
  (when (= (-> item :media :content-type) "text/html")
    (iframe-video-item item)))

(defn feeds-as-list [feeds]
  [:ul {:class "feed"} ; TODO remove list bullet
   (for [feed feeds]
     [:li  (-> (:items feed) video-items feed-items)])])

#_ (defn toggle-nav [app-state]
  (swap! app-state update :nav-open? (fn [nav-open?] (not nav-open?))))

#_ (defn toggle-dropdown [app-state]
  (swap! app-state update :dropdown-open? (fn [dropdown-open?] (not dropdown-open?))))


(defn hello-world [app-state]
  (fn []
    [:div
     #_ [b/Navbar
      
      [b/NavbarBrand "HolaB"]
      [b/NavbarToggler {:on-click #(toggle-nav app-state)} [:span "menu"]]
      [b/Collapse {:is-open (get @app-state :nav-open?) :navbar true}
       [b/Nav
         [b/NavItem [b/NavLink {:href "/"} "Hola"]]
         [b/NavItem [b/NavLink {:href "#"} "Hola 2"]]
         
         [b/NavItem
           [b/UncontrolledDropdown
             [b/DropdownToggle {:caret true :on-click #(toggle-dropdown app-state)} "Dropdown"]
             [b/DropdownMenu
               [b/DropdownItem {:header true} "Header"]
               [b/DropdownItem [b/NavLink {:href "/"} "Hola 3"]]]]]
           
         
         ]]
         
      
      

      ]

     ;[:h1 (:text @app-state)]
     ;[:h2 "You are " (get @(:active-user @app-state) :name "Anonymous cow")]
     ;[:h3 "Edit This and watch it change!"]
     ;[:p "We've reloaded " [:strong (:__figwheel_counter @app-state)] " times (not counting errorz)."]
     ;[b/Button {:color    "danger"
     ;           :on-click #(js/alert "HOLA")}
     ; "Say Hola"]
     (feeds-as-list @feeds)]))

(defn on-js-reload []
  ;; optionally touch your app-state to force rerendering depending on
  ;; your application
  (swap! app-state update-in [:__figwheel_counter] inc))

(defn ^:export login []
  (reset! active-user {:name "Harlan TimE"}))

(defn get-rss-feed [url]
  (println "getting rss feed: " url)
  (go (let [response (<! (http/get url
                                   {:with-credentials? false
                                    :response-type :document}))]
        (:body response))))

(defn parse-media [item-node]
  (when-let [media-group-node (.querySelector item-node "*|group")]
    (let [content-node (.querySelector media-group-node "*|content")
          url (.getAttribute content-node "url")
          content-type (.getAttribute content-node "type")
          height (.getAttribute content-node "height")
          width (.getAttribute content-node "width")
          media {:url url
                 :content-type content-type
                 :height height
                 :width width}]
      media)))

(defn map-rss-feed-item [item-node]
  (let [title (-> item-node (.querySelector "title") .-textContent .trim)
        guid (-> item-node (.querySelector "guid") .-textContent .trim)
        description (-> item-node (.querySelector "description") .-textContent .trim)
        pub-date (new js/Date (-> item-node (.querySelector "pubDate") .-textContent .trim))
        url (-> item-node (.querySelector "|link") .-textContent .trim)

        object-type-node (.querySelector item-node "*|object-type")
        object-type (when object-type-node (-> object-type-node .-textContent .trim))

        media (parse-media item-node)

        yt-id (.querySelector item-node "*|videoId")
        yt-id (when yt-id (-> yt-id .-textContent .trim))

        object-type (when object-type-node (-> object-type-node .-textContent .trim))]
    {:guid guid
     :key guid
     :title title
     :feed-title "Feed Title" ; TODO
     :pub-date pub-date
     :description description
     :url url
     :yt-id yt-id
     :media media
     :object-type object-type
     :node item-node}))

(defn map-rss-feed [feed-doc]
  (let [title (-> feed-doc (.querySelector "title") .-textContent .trim)
        items (map map-rss-feed-item (-> feed-doc (.querySelectorAll "item") aclone))]
    {:title title
     :items items
     :doc feed-doc}))

(defn get-rss-sources []
  (let [hash (-> js/document .-location .-hash)]
    (filter #(not (empty? %)) (str/split (.substr hash 1) ";"))))

(defn ^:export add-feeds! []
  (println "add-feeds!" js/document.location.hash)
  (doseq [url (get-rss-sources)]
    (go
      (let [feed (map-rss-feed (<! (get-rss-feed url)))]
        (swap! feeds conj feed)
        (println "done" feed)))))

(defn init! []
  (r/render-component [(hello-world app-state)]
                      (. js/document (getElementById "app")))
  (when (= (count (get-rss-sources)) 0)
    (set! js/document.location.hash (str "#" (or js/window.DEFAULT_FEED "/feed.xml"))))
  (add-feeds!)
  nil)

(def state (atom {}))

(defn dispatch-feed-added [])

(defn dispatch-feed-item-added [])







(defonce __initialized! (init!))