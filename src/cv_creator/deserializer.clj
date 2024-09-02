(ns cv-creator.deserializer
  (:require [clojure.data.json :as json]))

; TODO: don't hardcode data file path
(def deserialize (json/read-str (slurp "sample_data_en.json")
                                :key-fn keyword))
