(ns cryogen.core
  (:require [cryogen-core.compiler :refer [compile-assets-timed]]
            [cryogen-core.plugins :refer [load-plugins]]
            [selmer.filters :as selmer-filters]))

(defn -main []
  
  (load-plugins)
  (println "ADDING MOD FILTER 1")
(selmer-filters/add-filter! :mod (fn [x y] [:safe (mod x (read-string y))]))
  (compile-assets-timed)
  (System/exit 0))
