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

(defn create-cv [languageKey tags data] (cv-creator.html-renderer/create-html (:sections (languageKey data))))

; TODO: don't hardcode data file path
; TODO: don't hardcode language
(defn -main [] (println
                (create-cv :english [] (cv-creator.deserializer/deserialize "sample_data_en.json"))))
