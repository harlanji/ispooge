(defproject cryogen "0.1.0"
            :description "Simple static site generator"
            :url "https://github.com/lacarmen/cryogen"
            :license {:name "Eclipse Public License"
                      :url "http://www.eclipse.org/legal/epl-v10.html"}
            :dependencies [[org.clojure/clojure "1.8.0"]
                           [ring/ring-devel "1.6.3"]
                           [selmer "1.11.2"]
                           [compojure "1.6.0"]
                           [ring-server "0.5.0"]
                           [cryogen-markdown "0.1.7"]
                           [cryogen-core "0.1.60"]]
            :plugins [[lein-ring "0.9.7"]]
            :main cryogen.core
            ;:jvm-opts ["-Xmx1G" "-Xverify:none"] ; additive by default -- https://github.com/technomancy/leiningen/pull/1230
            :uberjar-name "app.jar"
            :ring {:init cryogen.server/init
                   :handler cryogen.server/handler})
