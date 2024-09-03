(ns cv-creator.deserializer
  (:require [clojure.data.json :as json]
            [cv-creator.section]))

(def deserializer-dispatcher-map {:autodidactTraining cv-creator.section/create-autodidact-training-section-from-map
                                  :skillSummary cv-creator.section/create-section-from-map
                                  :honors cv-creator.section/create-section-from-map
                                  :publications cv-creator.section/create-section-from-map
                                  :socialImplications cv-creator.section/create-section-from-map
                                  :contributedTalks cv-creator.section/create-section-from-map
                                  :head cv-creator.section/create-head-section-from-map
                                  :experiences cv-creator.section/create-section-from-map
                                  :education cv-creator.section/create-section-from-map})

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
