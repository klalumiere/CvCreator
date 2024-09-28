(ns cv-creator.deserializer
  (:require [clojure.data.json :as json]
            [clojure.java.io]
            [clojure.string]

            [cv-creator.section]
            [cv-creator.utility :as utility]))

(def deserializer-dispatcher-map {:autodidactTraining cv-creator.section/create-autodidact-training-section-from-map
                                  :contributedTalks cv-creator.section/create-section-from-map
                                  :education cv-creator.section/create-education-section-from-map
                                  :experiences cv-creator.section/create-experience-section-from-map
                                  :head cv-creator.section/create-head-section-from-map
                                  :honors cv-creator.section/create-section-from-map
                                  :publications cv-creator.section/create-section-from-map
                                  :skillSummary cv-creator.section/create-section-from-map
                                  :socialImplications cv-creator.section/create-section-from-map})

(def possible-section-names #{"autodidactTraining"
                              "contributedTalks"
                              "education"
                              "experiences"
                              "head"
                              "honors"
                              "publications"
                              "skillSummary"
                              "socialImplications"})

(defn dispatch-deserialization [key value] (let [constructor (key deserializer-dispatcher-map)]
                                             (if (nil? constructor) value (constructor value))))

(defn- deserialize-json [str] (json/read-str str
                                             :key-fn keyword
                                             :value-fn dispatch-deserialization))

(defn deserialize-cv [json] (let [{metadata :metadata :as content} json]
                              {(utility/get-language-key metadata)
                               {:label (utility/get-language-label metadata)
                                :sections (utility/get-ordered-sections metadata content)}}))

(defn deserialize [filePath] (deserialize-cv (deserialize-json (slurp filePath))))

(defn list-jsons-in-folder [folder] (filter #(clojure.string/includes? % "json")
                                            (.list (clojure.java.io/file folder))))

(defn deserialize-folder [folder] (->>
                                   (list-jsons-in-folder folder)
                                   (map #(str folder "/" %))
                                   (map deserialize)
                                   (reduce merge)))
