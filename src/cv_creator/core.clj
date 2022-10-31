(ns cv-creator.core
  (:require [ring.adapter.jetty :as jetty])
  (:gen-class))

(defn handler [request]
  {:status 200
   :headers {"Content-Type" "text/plain"}
   :body "Hello, World! :-)"})

(defn -main []
  (jetty/run-jetty handler {:port 8080}))
