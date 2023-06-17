(ns cv-creator.html-renderer
  (:require

   [selmer.parser :as selmer]))

(defprotocol HtmlRenderer
  (render-html [this]))

(defn create-html [content] (selmer/render "<div class=\"cvStyle\">{{content|safe}}</div>"
                                           {:content content}))
