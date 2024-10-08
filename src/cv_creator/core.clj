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
(declare
 create-cv
 validate-args-and-create-cv
 collect-tags
 filter-tags

 collect-tags-accumulating
 collect-tags-from-collection
 count-default-tags
 generate-error-message
 get-metadata-tags
 invalid-language?
 invalid-tags?
 tags-in-common?)

(def instrumented (= "true" (string/lower-case (or (System/getenv "CV_CREATOR_SPECS_INSTRUMENTED") "false"))))

(when instrumented (spectest/instrument (spectest/enumerate-namespace 'cv-creator.deserializer)))

(def error-keyword :cvCreatorError)


(defn -main [dataFolder language & rawTags]
  (let [tags (or (string/join "," rawTags) "")]
    (println
     (validate-args-and-create-cv :language language :errorMessage "invalid" :tags tags
                                  :data (cv-creator.deserializer/deserialize-folder dataFolder)))))


(defn create-cv [languageKey tags data]
  (when instrumented
    (let [defaultTagsCount (count-default-tags data)]
      (assert (<= defaultTagsCount 1) (str "Expected a single default tag, but got " defaultTagsCount))))
  (let [localizedCv (languageKey data)
        sections (:sections localizedCv)]
    (when instrumented
      (let [metadataTags (get-metadata-tags localizedCv)
            usedTags (collect-tags sections)]
        (assert (every? metadataTags usedTags) (str "Expected " usedTags " to be in " metadataTags))))
    (cv-creator.html-renderer/create-html (filter-tags sections tags))))

(defn validate-args-and-create-cv [& {:keys [language tags data errorMessage]}]
  (let [tagsAsSet (set (remove empty? (string/split (or tags "") #",")))]
    (cond
      (invalid-language? language data) (generate-error-message errorMessage "language")
      (invalid-tags? tagsAsSet ((keyword language) data)) (generate-error-message errorMessage "tags")
      :else (create-cv (keyword language) tagsAsSet data))))


(defn collect-tags [data] (collect-tags-accumulating data #{}))

(defn filter-tags [data tags]
  (if (vector? data)
    (->> data
         (filter #(tags-in-common? % tags))
         (map (fn [x] (utility/update-if-exist x :items #(filter-tags % tags))))
         (map (fn [x] (utility/update-if-exist x :optionalCourses #(first (filter-tags [%] tags)))))
         (map (fn [x] (utility/update-if-exist x :relevantReadings #(first (filter-tags [%] tags)))))
         (map (fn [x] (utility/update-if-exist x :subitems #(filter-tags % tags)))))
    data))


(defn- collect-tags-accumulating [data accumulator]
  (if (vector? data)
    (clojure.set/union
     accumulator
     (collect-tags-from-collection data)
     (reduce clojure.set/union (map (fn [x] (collect-tags-accumulating (:items x) #{})) data))
     (reduce clojure.set/union (map (fn [x] (collect-tags-accumulating (:subitems (:optionalCourses x)) #{})) data))
     (reduce clojure.set/union (map (fn [x] (collect-tags-accumulating (:subitems (:relevantReadings x)) #{})) data))
     (reduce clojure.set/union (map (fn [x] (collect-tags-accumulating (:subitems x) #{})) data)))
    accumulator))

(defn- collect-tags-from-collection [collection] (reduce clojure.set/union (map set (map :tags collection))))

(defn- count-default-tags [data] (->> data
                                      (map (fn [[_ value]] (:default value)))
                                      (map #(if % 1 0))
                                      (reduce +)))

(defn- generate-error-message [errorMessage problematicParameter]
  (if (empty? errorMessage) error-keyword (str errorMessage " " problematicParameter)))

(defn- get-metadata-tags [localizedCv] (set (map :value (:tags localizedCv))))

(defn- invalid-language? [language data] (or
                                          (empty? language)
                                          ; This is a bit complicated, but safer than using `keyword` on the user-supplied language
                                          (not (contains? (set (map name (keys data))) language))))

(defn- invalid-tags? [tags localizedCv]
  (not (every? (get-metadata-tags localizedCv) tags)))

(defn- tags-in-common? [object tags]
  (let [objectTags (:tags object)]
    (or (empty? objectTags)
        (seq (clojure.set/intersection tags (set objectTags))))))
