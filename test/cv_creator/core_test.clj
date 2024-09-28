(ns cv-creator.core-test
  (:require
   [clojure.test :as test]

   [cv-creator.core :as core]
   [cv-creator.section :as section]))

(def a-tag "arbitrary")
(def another-tag "anotherArbitrary")
(def a-section-without-items (section/create-section-from-map {:label "sectionLabel"
                                                              :items []}))
(def a-section-without-tags (section/create-section-from-map {:label "sectionLabel"
                                                              :items [{:value "An item with subitems"
                                                                       :subitems [{:value "An item"} {:value "An item"}]}]}))
(def a-section-without-tagged-subitems (section/create-section-from-map {:label "sectionLabel"
                                                              :items [{:value "An item with subitems"
                                                                       :subitems [{:value "An item"} ]}]}))

(def a-section-with-tags (section/create-section-from-map {:label "sectionLabel"
                                                           :tags [a-tag]
                                                           :items [{:value "An item with subitems"
                                                                    :subitems [{:value "An item"} {:value "An item"}]}]}))
(def a-section-with-item-with-tags (section/create-section-from-map {:label "sectionLabel"
                                                           :items [{:value "An item with subitems"
                                                                    :subitems [{:value "An item"} {:value "An item"}]
                                                                    :tags [a-tag]
                                                                    }]}))
(def a-section-with-subitem-with-tags (section/create-section-from-map {:label "sectionLabel"
                                                                     :items [{:value "An item with subitems"
                                                                              :subitems [{:value "An item" :tags [a-tag]}
                                                                                         {:value "An item"}]}]}))

(test/deftest filter-tags
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
    (test/is (not (= "<div class=\"cvStyle\"></div>"
                     (core/create-cv :english [] {:english
                                                  {:label "English"
                                                   :sections [(section/create-section-from-map
                                                               {:label "aLabel" :items [{:value "aValue"}]})]}}))))))
