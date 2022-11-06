(ns cv-creator.server
  (:require [compojure.core :refer :all]
            [compojure.route :as route])
  (:gen-class))

(defroutes app
  (GET "/" [] "<h1>Hello World</h1>")
  (route/not-found ""))
