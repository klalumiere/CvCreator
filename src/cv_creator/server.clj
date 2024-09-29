(ns cv-creator.server
  #_{:clj-kondo/ignore [:deprecated-namespace]}
  (:require
   [clojure.string :as string]
   
   [compojure.core :as compojure]
   [compojure.handler]
   [compojure.route :as route]
   
   [cv-creator.core]
   [cv-creator.deserializer])
  (:gen-class))

(def cv-creator-data-dir-path (or (System/getenv "CV_CREATOR_DATA_PATH") "data/sample"))

(def cv-creator-data (cv-creator.deserializer/deserialize-folder cv-creator-data-dir-path))

; TODO: remove this when we're ready to deploy in production
(compojure/defroutes trivial-impl
  (compojure/GET "/" [] "<h1>Hello World</h1>")
  (route/not-found ""))

(compojure/defroutes app-impl
  (compojure/GET "/cvcreator" [language tags]
    (cv-creator.core/create-cv (keyword language) (set (string/split tags #",")) cv-creator-data))
  (route/not-found ""))

; I prefer using deprecated API than adding the new dependency
; `ring-clojure/ring-defaults` with a version < 1 (with no new commit since 8 months)
#_{:clj-kondo/ignore [:clojure-lsp/unused-public-var]}
(def app #_{:clj-kondo/ignore [:deprecated-var]}
          (-> app-impl compojure.handler/api))
