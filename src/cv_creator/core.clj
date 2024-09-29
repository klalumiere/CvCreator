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

(defn- tags-in-common? [object tags]
  (let [objectTags (:tags object)]
    (or (empty? objectTags)
        (seq (clojure.set/intersection tags (set objectTags))))))

(defn filter-tags [data tags]
  (if (vector? data)
    (->> data
         (filter #(tags-in-common? % tags))
         (map (fn [x] (utility/update-if-exist x :items #(filter-tags % tags))))
         (map (fn [x] (utility/update-if-exist x :optionalCourses #(first (filter-tags [%] tags)))))
         (map (fn [x] (utility/update-if-exist x :relevantReadings #(first (filter-tags [%] tags)))))
         (map (fn [x] (utility/update-if-exist x :subitems #(filter-tags % tags)))))
    data))

(defn create-cv [languageKey tags data] (cv-creator.html-renderer/create-html
                                         (filter-tags (:sections (languageKey data)) tags)))

(defn validate-args-and-create-cv [& {:keys [language tags data errorMessage]}]
  (create-cv (keyword language) (set (string/split tags #",")) data))

(defn -main [dataFolder language & rawTags]
  (let [tags (or (string/join "," rawTags) "")]
    (println
     (validate-args-and-create-cv :language language
                                  :tags tags :data (cv-creator.deserializer/deserialize-folder dataFolder)))))
