(ns cv-creator.section)

(defrecord Section [label items tags])

(defrecord HeadSection [name
                        eMail
                        addressDoor
                        addressTown
                        webPage
                        phone])

(defrecord AutodidactTrainingSection [label
                                      relevantReadings
                                      optionalCourses])


(defrecord Item [value subitems tags])

(defrecord AutodidactTrainingItem [label subitems])

(defrecord EducationItem [degree school date subitems])
(defrecord ExperienceItem [title business date subitems])
(defrecord PhoneItem [label value])
(defrecord WebPageItem [label value])


(defrecord EducationSubitem [label value])
(defrecord OptionalCoursesSubitem [title place])
(defrecord RelevantReadingsSubitem [authors title])


(defn- update-if-exist [aMap key f]
  (if (nil? (key aMap)) aMap (update aMap key f)))


(defn create-item-from-map [aMap] (cv-creator.section/map->Item
                                      (-> aMap
                                          (update-if-exist :subitems #(mapv cv-creator.section/map->Item %)))))

(defn create-education-item-from-map [aMap] (cv-creator.section/map->EducationItem
                                   (-> aMap
                                       (update-if-exist :subitems #(mapv cv-creator.section/map->EducationSubitem %)))))

(defn create-optional-courses-item-from-map [aMap] (cv-creator.section/map->AutodidactTrainingItem
                                   (-> aMap
                                       (update-if-exist :subitems #(mapv cv-creator.section/map->OptionalCoursesSubitem %)))))

(defn create-relevant-readings-item-from-map [aMap] (cv-creator.section/map->AutodidactTrainingItem
                                                    (-> aMap
                                                        (update-if-exist :subitems #(mapv cv-creator.section/map->RelevantReadingsSubitem %)))))


(defn create-section-from-map [aMap] (cv-creator.section/map->Section
                                           (-> aMap
                                               (update-if-exist :items #(mapv create-item-from-map %)))))

(defn create-autodidact-training-section-from-map [aMap] (cv-creator.section/map->AutodidactTrainingSection
                                           (-> aMap
                                               (update-if-exist :relevantReadings #(create-relevant-readings-item-from-map %))
                                               (update-if-exist :optionalCourses #(create-optional-courses-item-from-map %)))))

(defn create-education-section-from-map [aMap] (cv-creator.section/map->Section
                                      (-> aMap
                                          (update-if-exist :items #(mapv create-education-item-from-map %)))))

(defn create-head-section-from-map [aMap] (cv-creator.section/map->HeadSection
                                           (-> aMap
                                               (update-if-exist :phone #(cv-creator.section/map->PhoneItem %))
                                               (update-if-exist :webPage #(cv-creator.section/map->WebPageItem %)))))