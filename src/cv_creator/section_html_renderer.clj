(ns cv-creator.section-html-renderer
  (:require
   [cv-creator.section]
   [cv-creator.html-renderer])
  (:import [cv_creator.section HeadSection]))

(extend-type HeadSection cv-creator.html-renderer/HtmlRenderer
             (render-html [this] (get this :name)))
