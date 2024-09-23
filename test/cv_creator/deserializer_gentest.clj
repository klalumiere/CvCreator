(ns cv-creator.deserializer-gentest
  (:require
   [clojure.spec.test.alpha :as spectest]

   [cv-creator.deserializer :as deserializer]))

; TODO: make this run!
(defn -main [] (spectest/check 'cv-creator.deserializer/deserialize-cv))
