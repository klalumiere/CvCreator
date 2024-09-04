(ns cv-creator.core
  (:require
   [cv-creator.deserializer]
   [cv-creator.html-renderer]
   [cv-creator.section-html-renderer]
   [cv-creator.section]))

(defn create-cv [languageKey tags data] (cv-creator.html-renderer/create-html (languageKey data)))

; TODO: don't hardcode data file path
; TODO: don't hardcode language
(defn -main [] (println
                (create-cv :english [] (cv-creator.deserializer/deserialize "sample_data_en.json"))))
