(ns cv-creator.html-renderer)

(defprotocol HtmlRenderer
  (render-html [this]))
