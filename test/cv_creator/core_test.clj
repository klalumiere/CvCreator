(ns cv-creator.core-test
  (:require
   [cv-creator.section]
   [cv-creator.html-renderer]
   [cv-creator.section-html-renderer]
   [clojure.string :as string]
   [clojure.test :as test]))

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
                    (create-arbitrary-head-section)))))))

