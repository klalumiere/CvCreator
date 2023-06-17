(ns cv-creator.core
  (:require
   [cv-creator.html-renderer]
   [cv-creator.section-html-renderer]
   [cv-creator.section]))

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
  (println (cv-creator.html-renderer/render-html (create-arbitrary-head-section))))
