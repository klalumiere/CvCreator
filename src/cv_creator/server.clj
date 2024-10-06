(ns cv-creator.server
  #_{:clj-kondo/ignore [:deprecated-namespace]}
  (:require
   [compojure.core :as compojure]
   [compojure.handler]
   [compojure.route :as route]
   [ring.middleware.json]

   [cv-creator.core]
   [cv-creator.deserializer]
   [cv-creator.utility :as utility])
  (:gen-class))

(def cv-creator-data-dir-path (or (System/getenv "CV_CREATOR_DATA_PATH") "data/sample"))

(def cv-creator-data (cv-creator.deserializer/deserialize-folder cv-creator-data-dir-path))

(def json-header {"Content-Type" "application/json"})
(def result-bad-request {:status 400})

(compojure/defroutes app-impl
  (compojure/GET "/cvcreator" [language tags]
    (let [result (cv-creator.core/validate-args-and-create-cv :language language :tags tags :data cv-creator-data)]
      (if (= result cv-creator.core/error-keyword) result-bad-request result)))
  (compojure/GET "/cvcreator/menu" []
    {:status  200 :headers json-header :body (utility/drop-sections cv-creator-data)})
  (route/not-found ""))

; TODO: remove this when we're ready to deploy in production
(compojure/defroutes trivial-impl
  (compojure/GET "/" [] "<h1>Hello World</h1>")
  (route/not-found ""))

; I prefer using deprecated API than adding the new dependency
; `ring-clojure/ring-defaults` with a version < 1 (with no new commit since 8 months)
#_{:clj-kondo/ignore [:clojure-lsp/unused-public-var]}
(def app
  (-> trivial-impl
      compojure.handler/api
      ring.middleware.json/wrap-json-response))
