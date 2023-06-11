(ns cv-creator.core-test
  (:require
   [cv-creator.section]
   [cv-creator.html-renderer]
   [cv-creator.section-html-renderer]
   [clojure.string :as string]
   [clojure.test :as test]))

(test/deftest html-renderer
  (test/testing "render-html HeadSection is not empty"
    (test/is (not (string/blank?
                    (cv-creator.html-renderer/render-html
                     (cv-creator.section/->HeadSection "1" "2" "3" "4" "5" "6" "7")))))))
