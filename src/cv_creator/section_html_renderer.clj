(ns cv-creator.section-html-renderer
  (:require
   [cv-creator.section]
   [cv-creator.html-renderer]
   [selmer.parser :as selmer])
  (:import [cv_creator.section HeadSection]))

(extend-type HeadSection cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (selmer/render "yo
{{name}}" this)))
