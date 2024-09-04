(ns cv-creator.core
  (:require
   [cv-creator.deserializer]
   [cv-creator.html-renderer]
   [cv-creator.section-html-renderer]
   [cv-creator.section]))

; TODO: don't hardcode data file path
; TODO: don't hardcode language
(defn -main [] (println (cv-creator.html-renderer/create-html
                         (:english (cv-creator.deserializer/deserialize "sample_data_en.json")))))
