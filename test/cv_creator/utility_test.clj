(ns cv-creator.utility-test
  (:require
   [clojure.test :as test]

   [cv-creator.utility :as utility]))

(test/deftest utility

  (test/testing "get-ordered-sections returns sections in order"
    (test/is (= ["info" "summary"]
                (utility/get-ordered-sections {:order ["head" "skillSummary"]} {:skillSummary "summary" :head "info"}))))

  (test/testing "get-language-label returns language label"
    (test/is (= "English" (utility/get-language-label {:language {:label "English"}}))))

  (test/testing "get-language-key returns language key"
    (test/is (= :en (utility/get-language-key {:language {:value "en"}}))))

  (test/testing "not-nil? false"
    (test/is (= false (utility/not-nil? nil))))

  (test/testing "not-nil? true"
    (test/is (= true (utility/not-nil? {:test 2}))))

  (test/testing "update-if-exist update existing key"
    (test/is (= {:test 3} (utility/update-if-exist {:test 2} :test #(+ % 1)))))

  (test/testing "update-if-exist doesn't update non-existing key"
    (test/is (= {:test 2} (utility/update-if-exist {:test 2} :anotherkey #(+ % 1))))))
