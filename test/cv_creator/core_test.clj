(ns cv-creator.core-test
  (:require
   [clojure.string :as string]
   [clojure.test :as test]

   [cv-creator.html-renderer]
   [cv-creator.section-html-renderer]
   [cv-creator.section]))


(def a-phone-item (cv-creator.section/map->PhoneItem {:label "Phone"
                                                      :item "(023) 456-7891"}))
(def a-section-label "arbitrary")
(def a-subitem-education (cv-creator.section/map->SubitemEducation {:label "Thesis"
                                                                    :subitem "How to have fun"}))
(def a-web-page-item (cv-creator.section/map->WebPageItem {:label "Web page"
                                                           :item "https://alain.terieur.com"}))
(def an-item (cv-creator.section/map->Item {:item "An item"}))


(def an-education-item (cv-creator.section/map->EducationItem {:degree "PhD"
                                                               :school "UdeS"
                                                               :date "2015"
                                                               :subitems [a-subitem-education]}))
(def an-experience-item (cv-creator.section/map->ExperienceItem {:title "Master"
                                                                 :business "Jedi School"
                                                                 :date "2017"
                                                                 :subitems [an-item]}))
(def an-head-section (cv-creator.section/map->HeadSection {:name "Alain Térieur"
                                                           :e-mail "alain.térieur@gmaille.com"
                                                           :address-door "123 Street"
                                                           :address-town "Montréal (Qc), Canada, H2T 2F6"
                                                           :web-page a-web-page-item
                                                           :phone a-phone-item}))
(def an-item-with-subitems (cv-creator.section/map->Item {:item "An item with subitems"
                                                          :subitems [an-item an-item]}))


(def a-section (cv-creator.section/map->Section {:label a-section-label
                                                 :items [an-item-with-subitems]}))


(test/deftest html-renderer

  (test/testing "render-html ExperienceItem is not empty"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html  an-experience-item)))))

  (test/testing "render-html EducationItem is not empty"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html an-education-item)))))

  (test/testing "render-html SubitemEducation is not empty"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html a-subitem-education)))))

  (test/testing "render-html-all is not empty when collection is not"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html-all [an-item])))))

  (test/testing "render-html-all is empty for empty collection"
    (test/is (string/blank?
              (cv-creator.html-renderer/render-html-all []))))

  (test/testing "render-html Section is not empty when items are not"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html a-section)))))

  (test/testing "render-html Section is empty when items are empty"
    (test/is (string/blank?
              (cv-creator.html-renderer/render-html (cv-creator.section/map->Section {:items []})))))

  (test/testing "render-html Item is empty if item is"
    (test/is (string/blank?
              (cv-creator.html-renderer/render-html (cv-creator.section/map->Item {:item ""})))))

  (test/testing "render-html Item is not empty"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html an-item-with-subitems)))))

  (test/testing "render-html PhoneItem is not empty when a phone number is provided"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html a-phone-item)))))

  (test/testing "render-html PhoneItem is empty when no phone number is provided"
    (test/is (string/blank?
              (cv-creator.html-renderer/render-html (cv-creator.section/map->PhoneItem {:label "Phone"
                                                                                        :item ""})))))

  (test/testing "render-html WebPageItem is not empty when a web page is provided"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html a-web-page-item)))))

  (test/testing "render-html WebPageItem is empty when no web page is provided"
    (test/is (string/blank?
              (cv-creator.html-renderer/render-html (cv-creator.section/map->WebPageItem {:label "Web page"
                                                                                          :item ""})))))

  (test/testing "render-html HeadSection is not empty"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html an-head-section)))))

  (test/testing "create-html is not empty"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/create-html "")))))

  (test/testing "create-html contains content passed in argument"
    (test/is (string/includes?
              (cv-creator.html-renderer/create-html [a-section]) a-section-label))))
