(ns cv-creator.core
  (:require
   [clojure.spec.test.alpha :as spectest]
   [clojure.string :as string]

   [cv-creator.deserializer]
   [cv-creator.deserializer-specs]
   [cv-creator.html-renderer]
   [cv-creator.section-html-renderer]
   [cv-creator.section]
   [cv-creator.utility]))

(when (let [instrumented (System/getenv "CV_CREATOR_SPECS_INSTRUMENTED")]
        (and (cv-creator.utility/not-nil? instrumented)
             (= (string/lower-case instrumented) "true")))
  (spectest/instrument (spectest/enumerate-namespace 'cv-creator.deserializer)))

(defn create-cv [language tags data] (cv-creator.html-renderer/create-html (:sections (language data))))

; TODO: don't hardcode data's file name
(defn -main [dataFolder language & rawTags]
  (let [tags (or rawTags [])]
    (println
     (create-cv (keyword language) tags (cv-creator.deserializer/deserialize (str dataFolder "/sample_en.json"))))))
