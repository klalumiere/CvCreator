(ns cv-creator.core-test
  (:require
   [clojure.test :as test]

   [cv-creator.core :as core]
   [cv-creator.section :as section]))

(test/deftest core
  (test/testing "create-cv is not empty"
    (test/is (not (= "<div class=\"cvStyle\"></div>"
                   (core/create-cv :english [] {
                                                :english
                                                {
                                                 :label "English"
                                                 :sections [(section/create-section-from-map
                                                             {:label "aLabel" :items [{:value "aValue"}]})]
                                                }
                                                } ))))))
