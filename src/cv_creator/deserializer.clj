(ns cv-creator.deserializer
  (:require [clojure.data.json :as json]
            [cv-creator.section]))

(def deserializer-dispatcher-map {:autodidactTraining cv-creator.section/map->AutodidactTrainingSection
                                  :skillSummary cv-creator.section/map->Section
                                  :honors cv-creator.section/map->Section
                                  :publications cv-creator.section/map->Section
                                  :socialImplications cv-creator.section/map->Section
                                  :contributedTalks cv-creator.section/map->Section
                                  :head cv-creator.section/map->HeadSection
                                  :experiences cv-creator.section/map->Section
                                  :education cv-creator.section/map->Section})

(defn- dispatch-deserialization [key value] (let [constructor (key deserializer-dispatcher-map)]
                                              (if (nil? constructor) value (constructor value))))

(defn- deserialize-sections [filePath] (json/read-str (slurp filePath)
                                             :key-fn keyword
                                             :value-fn dispatch-deserialization))

(defn- get-language-key [metadata] (keyword (:value (:language metadata))))

(defn- get-ordered-section-keys [metadata] (map keyword (:order metadata)))

(defn- get-ordered-sections [metadata content] (mapv #(get content %) (get-ordered-section-keys metadata)))

(defn deserialize [filePath] (let [{metadata :metadata :as content} (deserialize-sections filePath)]
                               { (get-language-key metadata) (get-ordered-sections metadata content)}))
