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

(def cv-creator-cross-origin (or (System/getenv "CV_CREATOR_CROSS_ORIGIN") "http://localhost:3000"))
(def cv-creator-data-dir-path (or (System/getenv "CV_CREATOR_DATA_DIR_PATH") "data/sample"))

(def cv-creator-data (cv-creator.deserializer/deserialize-folder cv-creator-data-dir-path))

(def access-control-allow-origin {"Access-Control-Allow-Origin" cv-creator-cross-origin})
(def content-type-html {"Content-Type" "text/html; charset=utf-8"})
(def content-type-json {"Content-Type" "application/json; charset=utf-8"})
(def http-status-bad-request 400)
(def http-status-ok 200)

(compojure/defroutes app-impl
  (compojure/GET "/cvcreator" [language tags]
    (let [result (cv-creator.core/validate-args-and-create-cv :language language :tags tags :data cv-creator-data)]
      (if (= result cv-creator.core/error-keyword) {:status http-status-bad-request}
          {:status  http-status-ok
           :headers (merge access-control-allow-origin content-type-html)
           :body result})))
  (compojure/GET "/cvcreator/menus" []
    {:status  http-status-ok
     :headers (merge access-control-allow-origin content-type-json)
     :body (utility/drop-sections cv-creator-data)})
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
