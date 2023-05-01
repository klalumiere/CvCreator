(ns cv-creator.core-test
  (:require
   [cv-creator.section]
   [cv-creator.html-renderer]
   [cv-creator.section-html-renderer]
   [clojure.string :as cstring]
   [clojure.test :as ctest]))

(ctest/deftest html-renderer
  (ctest/testing "render-html HeadSection is not empty"
    (ctest/is (not (cstring/blank?
                    (cv-creator.html-renderer/render-html
                     (cv-creator.section/->HeadSection "1" "2" "3" "4" "5" "6" "7")))))))
