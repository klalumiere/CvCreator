(ns cv-creator.server
  #_{:clj-kondo/ignore [:deprecated-namespace]}
  (:require
   [compojure.core :as compojure]
   [compojure.handler]
   [compojure.route :as route])
  (:gen-class))

(compojure/defroutes trivial-impl
  (compojure/GET "/" [] "<h1>Hello World</h1>")
  (route/not-found ""))

(compojure/defroutes app-impl
  (compojure/GET "/cvcreator" [language tags]
    (str "language=" language "tags=" tags))
  (route/not-found ""))

; I prefer using deprecated API than adding the new dependency
; `ring-clojure/ring-defaults` with a version < 1 (with no new commit since 8 months)
#_{:clj-kondo/ignore [:clojure-lsp/unused-public-var]}
(def app #_{:clj-kondo/ignore [:deprecated-var]}
          (-> app-impl compojure.handler/api))
