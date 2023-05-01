(ns cv-creator.server
  (:require
   [compojure.core :as ccore]
   [compojure.route :as croute])
  (:gen-class))

(ccore/defroutes app
  (ccore/GET "/" [] "<h1>Hello World</h1>")
  (croute/not-found ""))
