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
