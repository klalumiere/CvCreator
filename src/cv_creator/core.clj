(ns cv-creator.core
  (:require
   [cv-creator.html-renderer]
   [cv-creator.section-html-renderer]
   [cv-creator.section]))

(defn -main []
  (println (cv-creator.html-renderer/render-html (cv-creator.section/->HeadSection "1" "2" "3" "4" "5" "6" "7"))))
