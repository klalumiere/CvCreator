(ns cv-creator.server
  (:require
   [compojure.core :as compojure]
   [compojure.route :as route])
  (:gen-class))

#_{:clj-kondo/ignore [:clojure-lsp/unused-public-var]}
(compojure/defroutes app
  (compojure/GET "/" [] "<h1>Hello World</h1>")
  (route/not-found ""))
