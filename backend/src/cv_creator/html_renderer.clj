(ns cv-creator.html-renderer
  (:require
   [clojure.string :as string]

   [selmer.parser :as selmer]

   [cv-creator.utility :as utility]))
(declare render-html-all)


(defprotocol HtmlRenderer (render-html [this]))


(defn create-html [sections] (selmer/render "<div class=\"cvStyle\">{{content|safe}}</div>"
                                            {:content (render-html-all sections)}))

(defn render-html-all [collection] (string/join (map cv-creator.html-renderer/render-html (filter utility/not-nil? collection))))
