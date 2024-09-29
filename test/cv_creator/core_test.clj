(ns cv-creator.core-test
  (:require
   [clojure.test :as test]

   [cv-creator.core :as core]
   [cv-creator.section :as section]))

(def a-cv {:english
           {:label "English"
            :sections [(section/create-section-from-map
                        {:label "aLabel" :items [{:value "aValue"}]})]}})
(def a-tag "arbitrary")
(def another-tag "anotherArbitrary")
(def a-section-without-items (section/create-section-from-map {:label "sectionLabel"
                                                               :items []}))
(def a-section-without-tags (section/create-section-from-map {:label "sectionLabel"
                                                              :items [{:value "An item with subitems"
                                                                       :subitems [{:value "An item"} {:value "An item"}]}]}))
(def a-section-without-tagged-subitems (section/create-section-from-map {:label "sectionLabel"
                                                                         :items [{:value "An item with subitems"
                                                                                  :subitems [{:value "An item"}]}]}))
(def a-section-without-tagged-subitems-in-relevant-readings (section/create-section-from-map
                                                             {:label "sectionLabel"
                                                              :relevantReadings {:label "relevant readings"
                                                                                 :subitems [{:value "An item"}]}}))
(def a-section-without-tagged-subitems-in-optional-courses (section/create-section-from-map
                                                            {:label "sectionLabel"
                                                             :optionalCourses {:label "relevant readings"
                                                                               :subitems [{:value "An item"}]}}))

(def a-section-with-tags (section/create-section-from-map {:label "sectionLabel"
                                                           :tags [a-tag]
                                                           :items [{:value "An item with subitems"
                                                                    :subitems [{:value "An item"} {:value "An item"}]}]}))
(def a-section-with-item-with-tags (section/create-section-from-map {:label "sectionLabel"
                                                                     :items [{:value "An item with subitems"
                                                                              :subitems [{:value "An item"} {:value "An item"}]
                                                                              :tags [a-tag]}]}))
(def a-section-with-subitem-with-tags (section/create-section-from-map {:label "sectionLabel"
                                                                        :items [{:value "An item with subitems"
                                                                                 :subitems [{:value "An item" :tags [a-tag]}
                                                                                            {:value "An item"}]}]}))
(def a-section-with-subitem-with-tags-in-relevant-readings (section/create-section-from-map
                                                            {:label "sectionLabel"
                                                             :relevantReadings {:label "relevant readings"
                                                                                :subitems [{:value "An item" :tags [a-tag]}
                                                                                           {:value "An item"}]}}))
(def a-section-with-subitem-with-tags-in-optional-courses (section/create-section-from-map
                                                           {:label "sectionLabel"
                                                            :optionalCourses {:label "relevant readings"
                                                                              :subitems [{:value "An item" :tags [a-tag]}
                                                                                         {:value "An item"}]}}))


(test/deftest validate-args-and-create-cv
  ;; (test/testing "validate-args-and-create-cv is not empty"
  ;;   (test/is (not (= "<div class=\"cvStyle\"></div>"
  ;;                    (core/validate-args-and-create-cv :language "english" :tags "" :data a-cv)))))

  (test/testing "validate-args-and-create-cv is not empty"
    (test/is (not (= "<div class=\"cvStyle\"></div>"
                     (core/validate-args-and-create-cv :language "english" :tags "" :data a-cv))))))


(test/deftest filter-tags
  (test/testing "filter-tags filters subitems with different tags in optionalCourses"
    (test/is (= [a-section-without-tagged-subitems-in-optional-courses]
                (core/filter-tags [a-section-with-subitem-with-tags-in-optional-courses] #{another-tag}))))

  (test/testing "filter-tags keep subitems with same tags in optionalCourses"
    (test/is (= [a-section-with-subitem-with-tags-in-optional-courses]
                (core/filter-tags [a-section-with-subitem-with-tags-in-optional-courses] #{a-tag}))))

  (test/testing "filter-tags filters subitems with different tags in relevantReadings"
    (test/is (= [a-section-without-tagged-subitems-in-relevant-readings]
                (core/filter-tags [a-section-with-subitem-with-tags-in-relevant-readings] #{another-tag}))))

  (test/testing "filter-tags keep subitems with same tags in relevantReadings"
    (test/is (= [a-section-with-subitem-with-tags-in-relevant-readings]
                (core/filter-tags [a-section-with-subitem-with-tags-in-relevant-readings] #{a-tag}))))

  (test/testing "filter-tags filters subitems with different tags"
    (test/is (= [a-section-without-tagged-subitems] (core/filter-tags [a-section-with-subitem-with-tags] #{another-tag}))))

  (test/testing "filter-tags keep subitems with same tags"
    (test/is (= [a-section-with-subitem-with-tags] (core/filter-tags [a-section-with-subitem-with-tags] #{a-tag}))))

  (test/testing "filter-tags filters items with different tags"
    (test/is (= [a-section-without-items] (core/filter-tags [a-section-with-item-with-tags] #{another-tag}))))

  (test/testing "filter-tags keep items with same tags"
    (test/is (= [a-section-with-item-with-tags] (core/filter-tags [a-section-with-item-with-tags] #{a-tag}))))

  (test/testing "filter-tags keep sections with same tags"
    (test/is (= [a-section-with-tags] (core/filter-tags [a-section-with-tags] #{a-tag}))))

  (test/testing "filter-tags filters sections with different tags"
    (test/is (= [] (core/filter-tags [a-section-with-tags] #{another-tag}))))

  (test/testing "filter-tags returns section if it has no tags"
    (test/is (= [a-section-without-tags] (core/filter-tags [a-section-without-tags] #{}))))

  (test/testing "filter-tags handles nill"
    (test/is (= nil (core/filter-tags nil #{})))))


(test/deftest create-cv
  (test/testing "create-cv is not empty"
    (test/is (not (= "<div class=\"cvStyle\"></div>" (core/create-cv :english #{} a-cv))))))
