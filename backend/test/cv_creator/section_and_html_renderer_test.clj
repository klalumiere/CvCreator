(ns cv-creator.section-and-html-renderer-test
  (:require
   [clojure.string :as string]
   [clojure.test :as test]

   [cv-creator.html-renderer :as renderer]
   [cv-creator.section :as section]))


(def a-phone-item (section/map->PhoneItem {:label "Phone"
                                           :value "(023) 456-7891"}))
(def a-section-label "arbitrary")
(def a-subitem-education (section/map->EducationSubitem {:label "Thesis"
                                                         :value "How to have fun"}))
(def a-subitem-optional-courses (section/map->OptionalCoursesSubitem {:title "Cooking for dummies"
                                                                      :place "Restaurant"}))
(def a-subitem-relevant-readings (section/map->RelevantReadingsSubitem {:authors "TW et al."
                                                                        :title "SE at Google"}))
(def a-web-page-item (section/map->WebPageItem {:label "Web page"
                                                :value "https://alain.terieur.com"}))
(def an-item (section/map->Item {:value "An item"}))


(def an-autodidact-training-item (section/map->AutodidactTrainingItem {:label "Relevant readings"
                                                                       :subitems [a-subitem-relevant-readings]}))
(def an-education-item (section/map->EducationItem {:degree "PhD"
                                                    :school "UdeS"
                                                    :date "2015"
                                                    :subitems [a-subitem-education]}))
(def an-experience-item (section/map->ExperienceItem {:title "Master"
                                                      :business "Jedi School"
                                                      :date "2017"
                                                      :subitems [an-item]}))
(def an-head-section (section/map->HeadSection {:name "Alain Térieur"
                                                :eMail "alain.térieur@gmaille.com"
                                                :addressDoor "123 Street"
                                                :addressTown "Montréal (Qc), Canada, H2T 2F6"
                                                :webPage a-web-page-item
                                                :phone a-phone-item}))
(def an-item-with-subitems (section/map->Item {:value "An item with subitems"
                                               :subitems [an-item an-item]}))
(def an-optional-courses-item (section/map->AutodidactTrainingItem {:label "Optional courses"
                                                                    :subitems [a-subitem-optional-courses]}))
(def a-relevant-readings-item (section/map->AutodidactTrainingItem {:label "Relevant readings"
                                                                    :subitems [a-subitem-relevant-readings]}))


(def a-bullet-point-section (section/map->BulletPointSection {:label a-section-label
                                                              :items [an-item-with-subitems]}))
(def a-section (section/map->Section {:label a-section-label
                                      :items [an-item-with-subitems]}))
(def an-autodidact-training-section (section/map->AutodidactTrainingSection {:label "Autodidact training"
                                                                             :relevantReadings a-relevant-readings-item
                                                                             :optionalCourses an-optional-courses-item}))
(def an-education-section (section/map->Section {:label "Education"
                                                 :items [an-education-item]}))
(def an-experience-section (section/map->Section {:label "Experience"
                                                  :items [an-experience-item]}))


(test/deftest section

  (test/testing "create-autodidact-training-section-from-map creates a section from a map"
    (test/is (= an-autodidact-training-section
                (section/create-autodidact-training-section-from-map
                 {:label "Autodidact training"
                  :relevantReadings {:label "Relevant readings"
                                     :subitems [{:authors "TW et al." :title "SE at Google"}]}
                  :optionalCourses {:label "Optional courses"
                                    :subitems [{:title "Cooking for dummies" :place "Restaurant"}]}}))))

  (test/testing "create-bullet-point-section-from-map creates a section from a map"
    (test/is (= a-bullet-point-section
                (section/create-bullet-point-section-from-map
                 {:label a-section-label
                  :items [{:value "An item with subitems"
                           :subitems [{:value "An item"} {:value "An item"}]}]}))))

  (test/testing "create-section-from-map creates a section from a map"
    (test/is (= a-section
                (section/create-section-from-map
                 {:label a-section-label
                  :items [{:value "An item with subitems"
                           :subitems [{:value "An item"} {:value "An item"}]}]}))))

  (test/testing "create-education-section-from-map creates a section from a map"
    (test/is (= an-education-section
                (section/create-education-section-from-map
                 {:label "Education"
                  :items [{:degree "PhD"
                           :school "UdeS"
                           :date "2015"
                           :subitems [{:label "Thesis"
                                       :value "How to have fun"}]}]}))))

  (test/testing "create-experience-section-from-map creates a section from a map"
    (test/is (= an-experience-section
                (section/create-experience-section-from-map
                 {:label "Experience"
                  :items [{:title "Master"
                           :business "Jedi School"
                           :date "2017"
                           :subitems [{:value "An item"}]}]}))))

  (test/testing "create-head-section-from-map creates a section from a map"
    (test/is (= an-head-section
                (section/create-head-section-from-map
                 {:name "Alain Térieur"
                  :eMail "alain.térieur@gmaille.com"
                  :addressDoor "123 Street"
                  :addressTown "Montréal (Qc), Canada, H2T 2F6"
                  :webPage {:label "Web page"
                            :value "https://alain.terieur.com"}
                  :phone {:label "Phone"
                          :value "(023) 456-7891"}})))))


(test/deftest html-renderer

  (test/testing "render-html AutodidactTrainingItem is not empty"
    (test/is (not (string/blank?
                   (renderer/render-html an-autodidact-training-item)))))

  (test/testing "render-html OptionalCoursesSubitem is not empty"
    (test/is (not (string/blank?
                   (renderer/render-html a-subitem-optional-courses)))))

  (test/testing "render-html RelevantReadingsSubitem is not empty"
    (test/is (not (string/blank?
                   (renderer/render-html a-subitem-relevant-readings)))))

  (test/testing "render-html ExperienceItem is not empty"
    (test/is (not (string/blank?
                   (renderer/render-html an-experience-item)))))

  (test/testing "render-html EducationItem is not empty"
    (test/is (not (string/blank?
                   (renderer/render-html an-education-item)))))

  (test/testing "render-html SubitemEducation is not empty"
    (test/is (not (string/blank?
                   (renderer/render-html a-subitem-education)))))

  (test/testing "render-html-all is not empty when collection is not"
    (test/is (not (string/blank?
                   (renderer/render-html-all [an-item])))))

  (test/testing "render-html-all is empty for empty collection"
    (test/is (string/blank?
              (renderer/render-html-all []))))

  (test/testing "render-html-all handles nil collection"
    (test/is (string/blank?
              (renderer/render-html-all nil))))

  (test/testing "render-html BulletPointSection is not empty when items are not"
    (test/is (not (string/blank?
                   (renderer/render-html a-bullet-point-section)))))

  (test/testing "render-html BulletPointSection is empty when items are empty"
    (test/is (string/blank?
              (renderer/render-html (section/map->BulletPointSection {:items []})))))

  (test/testing "render-html Section is not empty when items are not"
    (test/is (not (string/blank?
                   (renderer/render-html a-section)))))

  (test/testing "render-html Section is empty when items are empty"
    (test/is (string/blank?
              (renderer/render-html (section/map->Section {:items []})))))

  (test/testing "render-html AutodidactTrainingSection is not empty when items are not"
    (test/is (not (string/blank?
                   (renderer/render-html an-autodidact-training-section)))))

  (test/testing "render-html AutodidactTrainingSection is not empty when relevantReadings are not"
    (test/is (not (string/blank?
                   (renderer/render-html (section/map->AutodidactTrainingSection
                                          {:label "Autodidact training"
                                           :relevantReadings a-relevant-readings-item}))))))

  (test/testing "render-html AutodidactTrainingSection is not empty when optionalCourses are not"
    (test/is (not (string/blank?
                   (renderer/render-html (section/map->AutodidactTrainingSection
                                          {:label "Autodidact training"
                                           :optionalCourses an-optional-courses-item}))))))

  (test/testing "render-html AutodidactTrainingSection is empty when items are empty"
    (test/is (string/blank?
              (renderer/render-html (section/map->AutodidactTrainingSection {:label "Autodidact training"})))))

  (test/testing "render-html Item is empty if item is"
    (test/is (string/blank?
              (renderer/render-html (section/map->Item {:value ""})))))

  (test/testing "render-html Item is not empty"
    (test/is (not (string/blank?
                   (renderer/render-html an-item-with-subitems)))))

  (test/testing "render-html PhoneItem is not empty when a phone number is provided"
    (test/is (not (string/blank?
                   (renderer/render-html a-phone-item)))))

  (test/testing "render-html PhoneItem is empty when no phone number is provided"
    (test/is (string/blank?
              (renderer/render-html (section/map->PhoneItem {:label "Phone"
                                                             :value ""})))))

  (test/testing "render-html WebPageItem is not empty when a web page is provided"
    (test/is (not (string/blank?
                   (renderer/render-html a-web-page-item)))))

  (test/testing "render-html WebPageItem is empty when no web page is provided"
    (test/is (string/blank?
              (renderer/render-html (section/map->WebPageItem {:label "Web page"
                                                               :value ""})))))

  (test/testing "render-html HeadSection is not empty"
    (test/is (not (string/blank?
                   (renderer/render-html an-head-section)))))

  (test/testing "create-html is not empty"
    (test/is (not (string/blank?
                   (renderer/create-html "")))))

  (test/testing "create-html contains content passed in argument"
    (test/is (string/includes?
              (renderer/create-html [a-section]) a-section-label))))
