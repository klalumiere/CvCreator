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

(defn deserialize-sections [filePath] (json/read-str (slurp filePath)
                                             :key-fn keyword
                                             :value-fn deserializer-dispatcher-map))

(defn deserialize [filePath] (deserialize-sections filePath))
