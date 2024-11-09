(ns cv-creator.section
  (:require
   [cv-creator.utility :as utility]))
(declare
 create-education-item-from-map
 create-experience-item-from-map
 create-item-from-map
 create-optional-courses-item-from-map
 create-relevant-readings-item-from-map)

(defrecord BulletPointSection [label items tags])
(defrecord Section [label items tags])

(defrecord HeadSection [name
                        eMail
                        addressDoor
                        addressTown
                        webPage
                        phone])

(defrecord AutodidactTrainingSection [label
                                      relevantReadings
                                      optionalCourses
                                      tags])


(defrecord Item [value subitems tags])

(defrecord AutodidactTrainingItem [label subitems tags])

(defrecord EducationItem [degree school date subitems])
(defrecord ExperienceItem [title business date subitems])
(defrecord PhoneItem [label value])
(defrecord WebPageItem [label value])


(defrecord EducationSubitem [label value])
(defrecord OptionalCoursesSubitem [title place])
(defrecord RelevantReadingsSubitem [authors title])


(defn create-autodidact-training-section-from-map [aMap] (map->AutodidactTrainingSection
                                                          (-> aMap
                                                              (utility/update-if-exist :relevantReadings #(create-relevant-readings-item-from-map %))
                                                              (utility/update-if-exist :optionalCourses #(create-optional-courses-item-from-map %)))))

(defn create-education-section-from-map [aMap] (map->Section
                                                (-> aMap
                                                    (utility/update-if-exist :items #(mapv create-education-item-from-map %)))))

(defn create-experience-section-from-map [aMap] (map->Section
                                                 (-> aMap
                                                     (utility/update-if-exist :items #(mapv create-experience-item-from-map %)))))

(defn create-head-section-from-map [aMap] (map->HeadSection
                                           (-> aMap
                                               (utility/update-if-exist :phone #(map->PhoneItem %))
                                               (utility/update-if-exist :webPage #(map->WebPageItem %)))))

(defn create-bullet-point-section-from-map [aMap] (map->BulletPointSection
                                                   (-> aMap
                                                       (utility/update-if-exist :items #(mapv create-item-from-map %)))))

(defn create-section-from-map [aMap] (map->Section
                                      (-> aMap
                                          (utility/update-if-exist :items #(mapv create-item-from-map %)))))


(defn- create-education-item-from-map [aMap] (map->EducationItem
                                              (-> aMap
                                                  (utility/update-if-exist :subitems #(mapv map->EducationSubitem %)))))

(defn- create-experience-item-from-map [aMap] (map->ExperienceItem
                                               (-> aMap
                                                   (utility/update-if-exist :subitems #(mapv map->Item %)))))

(defn- create-item-from-map [aMap] (map->Item
                                    (-> aMap
                                        (utility/update-if-exist :subitems #(mapv map->Item %)))))

(defn- create-optional-courses-item-from-map [aMap] (map->AutodidactTrainingItem
                                                     (-> aMap
                                                         (utility/update-if-exist :subitems #(mapv map->OptionalCoursesSubitem %)))))

(defn- create-relevant-readings-item-from-map [aMap] (map->AutodidactTrainingItem
                                                      (-> aMap
                                                          (utility/update-if-exist :subitems #(mapv map->RelevantReadingsSubitem %)))))
