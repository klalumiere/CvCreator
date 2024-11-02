(ns cv-creator.deserializer-test
  (:require
   [clojure.spec.test.alpha :as spectest]
   [clojure.test :as test]

   [cv-creator.deserializer-specs]
   [cv-creator.deserializer :as deserializer]
   [cv-creator.section :as section]))

(test/deftest deserializer

  (test/testing "dispatch-deserialization dipatches to correct 'constructor'"
    (test/is (= (section/create-section-from-map {:label "aLabel" :items [{:value "aValue"}]})
                (deserializer/dispatch-deserialization :contributedTalks {:label "aLabel" :items [{:value "aValue"}]})))))

(test/deftest ^:integration deserializer-gentest
  (let [{returnedValue :clojure.spec.test.check/ret :as result} (spectest/check 'cv-creator.deserializer/deserialize-cv
                                                                                {:clojure.spec.test.check/opts {:num-tests 100}})]
    (test/do-report result)
    (test/is (returnedValue :pass?))))
