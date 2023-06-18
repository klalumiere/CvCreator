(ns cv-creator.core
  (:require
   [cv-creator.html-renderer]
   [cv-creator.section-html-renderer]
   [cv-creator.section]))

(defn create-arbitrary-item []
  (cv-creator.section/map->Item {:item "An item"}))

(defn create-arbitrary-item-with-subitems []
  (cv-creator.section/map->Item {:item "An item with subitems"
                                 :subitems [(create-arbitrary-item) (create-arbitrary-item)]}))

(defn create-arbitrary-section []
  (cv-creator.section/map->Section {:label "arbitrary" :items [(create-arbitrary-item-with-subitems)]}))

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

(defn -main []
  (println (cv-creator.html-renderer/create-html
            [(create-arbitrary-head-section)
             (create-arbitrary-section)])))
