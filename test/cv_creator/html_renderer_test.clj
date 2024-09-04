(ns cv-creator.html-renderer-test
  (:require
   [clojure.string :as string]
   [clojure.test :as test]

   [cv-creator.html-renderer]
   [cv-creator.section-html-renderer]
   [cv-creator.section]))


(def a-phone-item (cv-creator.section/map->PhoneItem {:label "Phone"
                                                      :value "(023) 456-7891"}))
(def a-section-label "arbitrary")
(def a-subitem-education (cv-creator.section/map->EducationSubitem {:label "Thesis"
                                                                    :value "How to have fun"}))
(def a-subitem-optional-courses (cv-creator.section/map->OptionalCoursesSubitem {:title "Cooking for dummies"
                                                                                 :place "Restaurant"}))
(def a-subitem-relevant-readings (cv-creator.section/map->RelevantReadingsSubitem {:authors "TW et al."
                                                                                   :title "SE at Google"}))
(def a-web-page-item (cv-creator.section/map->WebPageItem {:label "Web page"
                                                           :value "https://alain.terieur.com"}))
(def an-item (cv-creator.section/map->Item {:value "An item"}))


(def an-autodidact-training-item (cv-creator.section/map->AutodidactTrainingItem {:label "Relevant readings"
                                                                                  :subitems [a-subitem-relevant-readings]}))
(def an-education-item (cv-creator.section/map->EducationItem {:degree "PhD"
                                                               :school "UdeS"
                                                               :date "2015"
                                                               :subitems [a-subitem-education]}))
(def an-experience-item (cv-creator.section/map->ExperienceItem {:title "Master"
                                                                 :business "Jedi School"
                                                                 :date "2017"
                                                                 :subitems [an-item]}))
(def an-head-section (cv-creator.section/map->HeadSection {:name "Alain Térieur"
                                                           :eMail "alain.térieur@gmaille.com"
                                                           :addressDoor "123 Street"
                                                           :addressTown "Montréal (Qc), Canada, H2T 2F6"
                                                           :webPage a-web-page-item
                                                           :phone a-phone-item}))
(def an-item-with-subitems (cv-creator.section/map->Item {:value "An item with subitems"
                                                          :subitems [an-item an-item]}))
(def an-optional-courses-item (cv-creator.section/map->AutodidactTrainingItem {:label "Optional courses"
                                                                               :subitems [a-subitem-optional-courses]}))
(def a-relevant-readings-item (cv-creator.section/map->AutodidactTrainingItem {:label "Relevant readings"
                                                                               :subitems [a-subitem-relevant-readings]}))


(def a-section (cv-creator.section/map->Section {:label a-section-label
                                                 :items [an-item-with-subitems]}))
(def an-autodidact-training-section (cv-creator.section/map->AutodidactTrainingSection {:label "Autodidact training"
                                                                                        :relevantReadings a-relevant-readings-item
                                                                                        :optionalCourses an-optional-courses-item}))


(test/deftest html-renderer

  (test/testing "render-html AutodidactTrainingItem is not empty"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html an-autodidact-training-item)))))

  (test/testing "render-html OptionalCoursesSubitem is not empty"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html a-subitem-optional-courses)))))

  (test/testing "render-html RelevantReadingsSubitem is not empty"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html a-subitem-relevant-readings)))))

  (test/testing "render-html ExperienceItem is not empty"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html an-experience-item)))))

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

  (test/testing "render-html AutodidactTrainingSection is not empty when items are not"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html an-autodidact-training-section)))))

  (test/testing "render-html AutodidactTrainingSection is not empty when relevantReadings are not"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html (cv-creator.section/map->AutodidactTrainingSection {:label "Autodidact training"
                                                                                                             :relevantReadings a-relevant-readings-item
                                                                                                             }))))))

  (test/testing "render-html AutodidactTrainingSection is not empty when optionalCourses are not"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html (cv-creator.section/map->AutodidactTrainingSection {:label "Autodidact training"
                                                                                                             :optionalCourses an-optional-courses-item}))))))

  (test/testing "render-html AutodidactTrainingSection is empty when items are empty"
    (test/is (string/blank?
              (cv-creator.html-renderer/render-html (cv-creator.section/map->AutodidactTrainingSection {:label "Autodidact training"})))))

  (test/testing "render-html Item is empty if item is"
    (test/is (string/blank?
              (cv-creator.html-renderer/render-html (cv-creator.section/map->Item {:value ""})))))

  (test/testing "render-html Item is not empty"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html an-item-with-subitems)))))

  (test/testing "render-html PhoneItem is not empty when a phone number is provided"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html a-phone-item)))))

  (test/testing "render-html PhoneItem is empty when no phone number is provided"
    (test/is (string/blank?
              (cv-creator.html-renderer/render-html (cv-creator.section/map->PhoneItem {:label "Phone"
                                                                                        :value ""})))))

  (test/testing "render-html WebPageItem is not empty when a web page is provided"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html a-web-page-item)))))

  (test/testing "render-html WebPageItem is empty when no web page is provided"
    (test/is (string/blank?
              (cv-creator.html-renderer/render-html (cv-creator.section/map->WebPageItem {:label "Web page"
                                                                                          :value ""})))))

  (test/testing "render-html HeadSection is not empty"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/render-html an-head-section)))))

  (test/testing "create-html is not empty"
    (test/is (not (string/blank?
                   (cv-creator.html-renderer/create-html "")))))

  (test/testing "create-html contains content passed in argument"
    (test/is (string/includes?
              (cv-creator.html-renderer/create-html [a-section]) a-section-label))))
