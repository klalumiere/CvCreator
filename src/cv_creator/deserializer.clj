(ns cv-creator.deserializer
  (:require [clojure.data.json :as json]
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

(defn dispatch-deserialization [key value] (let [constructor (key deserializer-dispatcher-map)]
                                             (if (nil? constructor) value (constructor value))))

(defn- deserialize-sections [filePath] (json/read-str (slurp filePath)
                                                      :key-fn keyword
                                                      :value-fn dispatch-deserialization))

(defn deserialize [filePath] (let [{metadata :metadata :as content} (deserialize-sections filePath)]
                               {(utility/get-language-key metadata)
                                {:label (utility/get-language-label metadata)
                                 :sections (utility/get-ordered-sections metadata content)}}))
