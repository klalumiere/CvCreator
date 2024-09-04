(ns cv-creator.core
  (:require
   [cv-creator.deserializer]
   [cv-creator.html-renderer]
   [cv-creator.section-html-renderer]
   [cv-creator.section]))

(defn -main [] (println (cv-creator.html-renderer/create-html (:english (cv-creator.deserializer/deserialize "sample_data_en.json")))))
