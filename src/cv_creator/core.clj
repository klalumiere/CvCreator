(ns cv-creator.core
  (:require
   [cv-creator.html-renderer]
   [cv-creator.section-html-renderer]
   [cv-creator.section]))


(def a-phone-item (cv-creator.section/map->PhoneItem {:label "Phone"
                                                      :item "(023) 456-7891"}))
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


(def an-education-section (cv-creator.section/map->Section {:label "Education" :items [an-education-item]}))
(def an-experience-section (cv-creator.section/map->Section {:label "Experience" :items [an-experience-item]}))
(def a-section (cv-creator.section/map->Section {:label "Arbitrary"
                                                 :items [an-item-with-subitems]}))


(defn -main [] (println (cv-creator.html-renderer/create-html [an-head-section
                                                               a-section
                                                               an-experience-section
                                                               an-education-section])))
