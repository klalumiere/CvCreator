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
                    (cv-creator.section/map->HeadSection {:name "Alain Térieur"
                                                          :e-mail "alain.térieur@gmaille.com"
                                                          :address-door "123 Street"
                                                          :address-town "Montréal (Qc), Canada, H2T 2F6"
                                                          :web-page "Web page"
                                                          :mobile "Mobile"
                                                          :phone "Phone"})))))))
