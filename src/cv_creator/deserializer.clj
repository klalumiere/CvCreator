(ns cv-creator.deserializer
  (:require [clojure.data.json :as json]
            [clojure.java.io]
            [clojure.string]

            [cv-creator.section]
            [cv-creator.utility :as utility]))
(declare
 deserialize
 deserialize-cv
 deserialize-folder
 deserialize-json
 list-jsons-in-folder)

(def deserializer-dispatcher-map {:autodidactTraining cv-creator.section/create-autodidact-training-section-from-map
                                  :contributedTalks cv-creator.section/create-section-from-map
                                  :education cv-creator.section/create-education-section-from-map
                                  :experiences cv-creator.section/create-experience-section-from-map
                                  :head cv-creator.section/create-head-section-from-map
                                  :honors cv-creator.section/create-section-from-map
                                  :publications cv-creator.section/create-section-from-map
                                  :skillSummary cv-creator.section/create-section-from-map
                                  :socialImplications cv-creator.section/create-section-from-map})

(def possible-section-names (set (map name (keys deserializer-dispatcher-map))))


(defn deserialize [filePath] (deserialize-cv (deserialize-json (slurp filePath))))

(defn deserialize-cv [json] (let [{metadata :metadata :as content} json]
                              {(utility/get-language-key metadata)
                               {:label (utility/get-language-label metadata)
                                :tags (:tags metadata)
                                :sections (utility/get-ordered-sections metadata content)}}))

(defn deserialize-folder [folder] (->>
                                   (list-jsons-in-folder folder)
                                   (map #(str folder "/" %))
                                   (map deserialize)
                                   (reduce merge)))

(defn dispatch-deserialization [key value] (let [constructor (key deserializer-dispatcher-map)]
                                             (if (nil? constructor) value (constructor value))))


(defn- deserialize-json [str] (json/read-str str
                                             :key-fn keyword
                                             :value-fn dispatch-deserialization))

(defn- list-jsons-in-folder [folder] (filter #(clojure.string/includes? % "json")
                                             (.list (clojure.java.io/file folder))))
