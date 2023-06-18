(ns cv-creator.core-test
  (:require
   [clojure.string :as string]
   [clojure.test :as test]

   [cv-creator.html-renderer]
   [cv-creator.section-html-renderer]
   [cv-creator.section]))

(def section-label "arbitrary")

(defn create-arbitrary-subitem-education []
  (cv-creator.section/map->SubitemEducation {:label "Thesis" :subitem "How to have fun"}))

(defn create-arbitrary-education-item []
  (cv-creator.section/map->EducationItem {:degree "PhD"
                                             :school "UdeS"
                                             :date "2015"
                                             :subitems [(create-arbitrary-subitem-education)]}))

(defn create-arbitrary-item []
  (cv-creator.section/map->Item {:item "An item"}))

(defn create-arbitrary-item-with-subitems []
  (cv-creator.section/map->Item {:item "An item with subitems"
                                 :subitems [(create-arbitrary-item) (create-arbitrary-item)]}))

(defn create-arbitrary-section []
  (cv-creator.section/map->Section {:label section-label :items [(create-arbitrary-item-with-subitems)]}))

(defn create-arbitrary-phone-item []
  (cv-creator.section/map->PhoneItem {:label "Phone"
                                      :item "(023) 456-7891"}))

(defn create-arbitrary-web-page-item []
  (cv-creator.section/map->WebPageItem {:label "Web page"
                                        :item "https://alain.terieur.com"}))

(defn create-arbitrary-head-section []
  (cv-creator.section/map->HeadSection {:name "Alain Térieur"
                                        :e-mail "alain.térieur@gmaille.com"
                                        :address-door "123 Street"
                                        :address-town "Montréal (Qc), Canada, H2T 2F6"
                                        :web-page (create-arbitrary-web-page-item)
                                        :phone (create-arbitrary-phone-item)}))

(test/deftest html-renderer

  (test/testing "render-html EducationItem is not empty"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html
                    (create-arbitrary-education-item))))))

  (test/testing "render-html SubitemEducation is not empty"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html
                    (create-arbitrary-subitem-education))))))

  (test/testing "render-html-all is not empty when collection is not"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html-all [(create-arbitrary-item)])))))

  (test/testing "render-html-all is empty for empty collection"
    (test/is (string/blank?
              (cv-creator.html-renderer/render-html-all []))))

  (test/testing "render-html Section is not empty when items are not"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html
                    (create-arbitrary-section))))))

  (test/testing "render-html Section is empty when items are empty"
    (test/is (string/blank?
              (cv-creator.html-renderer/render-html
               (cv-creator.section/map->Section {:items []})))))

  (test/testing "render-html Item is empty if item is"
    (test/is (string/blank?
              (cv-creator.html-renderer/render-html
               (cv-creator.section/map->Item {:item ""})))))

  (test/testing "render-html Item is not empty"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html
                    (create-arbitrary-item-with-subitems))))))

  (test/testing "render-html PhoneItem is not empty when a phone number is provided"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html
                    (create-arbitrary-phone-item))))))

  (test/testing "render-html PhoneItem is empty when no phone number is provided"
    (test/is (string/blank?
              (cv-creator.html-renderer/render-html
               (cv-creator.section/map->PhoneItem {:label "Phone"
                                                   :item ""})))))

  (test/testing "render-html WebPageItem is not empty when a web page is provided"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html
                    (create-arbitrary-web-page-item))))))

  (test/testing "render-html WebPageItem is empty when no web page is provided"
    (test/is (string/blank?
              (cv-creator.html-renderer/render-html
               (cv-creator.section/map->WebPageItem {:label "Web page"
                                                     :item ""})))))

  (test/testing "render-html HeadSection is not empty"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html
                    (create-arbitrary-head-section))))))

  (test/testing "create-html is not empty"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/create-html "")))))

  (test/testing "create-html contains content passed in argument"
    (test/is (string/includes?
              (cv-creator.html-renderer/create-html [(create-arbitrary-section)]) section-label))))
