(ns cv-creator.core
  (:require
   [clojure.spec.test.alpha :as spectest]
   [clojure.set]
   [clojure.string :as string]

   [cv-creator.deserializer]
   [cv-creator.deserializer-specs]
   [cv-creator.html-renderer]
   [cv-creator.section-html-renderer]
   [cv-creator.section]
   [cv-creator.utility :as utility]))

(when (let [instrumented (System/getenv "CV_CREATOR_SPECS_INSTRUMENTED")]
        (and (utility/not-nil? instrumented)
             (= (string/lower-case instrumented) "true")))
  (spectest/instrument (spectest/enumerate-namespace 'cv-creator.deserializer)))

(defn create-cv [language tags data] (cv-creator.html-renderer/create-html (:sections (language data))))

(defn tags-in-common? [object tags]
  (let [objectTags (get object :tags)]
    (or (empty? objectTags)
        (seq (clojure.set/intersection tags (set objectTags))))))

(defn filter-tags [data tags]
  (if (vector? data)
    (->> data
         (filter #(tags-in-common? % tags))
         (map (fn [element] (utility/update-if-exist element :items #(filter-tags % tags))))
         )
    data))

(defn -main [dataFolder language & rawTags]
  (let [tags (or (set rawTags) #{})]
    (println
     (create-cv (keyword language) tags (cv-creator.deserializer/deserialize-folder dataFolder)))))
