(ns cv-creator.html-renderer
  (:require
   [clojure.string :as string]

   [selmer.parser :as selmer]))


(defprotocol HtmlRenderer (render-html [this]))


(defn render-html-all [collection] (string/join (map cv-creator.html-renderer/render-html collection)))


(defn create-html [sections] (selmer/render "<div class=\"cvStyle\">{{content|safe}}</div>"
                                            {:content (render-html-all sections)}))
