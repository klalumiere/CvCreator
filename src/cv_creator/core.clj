(ns cv-creator.core
  (:require
   [cv-creator.html-renderer]
   [cv-creator.section-html-renderer]
   [cv-creator.section]))

(defn -main []
  (println (cv-creator.html-renderer/render-html (cv-creator.section/map->HeadSection {:name "Alain Térieur"
                                                                                       :e-mail "alain.térieur@gmaille.com"
                                                                                       :address-door "123 Street"
                                                                                       :address-town "Montréal (Qc), Canada, H2T 2F6"
                                                                                       :web-page "Web page"
                                                                                       :mobile "Mobile"
                                                                                       :phone "Phone"}))))
