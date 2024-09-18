(ns cv-creator.deserializer-test
  (:require
   [clojure.test :as test]

   [cv-creator.deserializer :as deserializer]
   [cv-creator.section :as section]))

(test/deftest deserializer

  (test/testing "dispatch-deserialization dipatches to correct 'constructor'"
    (test/is (= (section/create-section-from-map {:label "aLabel" :items [{:value "aValue"}]})
                (deserializer/dispatch-deserialization :contributedTalks {:label "aLabel" :items [ {:value "aValue"} ]})))))
