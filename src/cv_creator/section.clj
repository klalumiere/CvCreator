(ns cv-creator.section)

(defrecord Section [label items tags])

(defrecord HeadSection [name
                        eMail
                        addressDoor
                        addressTown
                        webPage
                        phone])


(defrecord Item [value subitems tags])

(defrecord AutodidactTrainingItem [label subitems])  ; should be two things: RelevantReadingsItem and OptionalCoursesItem 

(defrecord EducationItem [degree school date subitems])
(defrecord ExperienceItem [title business date subitems])
(defrecord PhoneItem [label value])
(defrecord WebPageItem [label value])


(defrecord SubitemEducation [label value])
(defrecord SubitemOptionalCourses [title place])
(defrecord SubitemRelevantReadings [authors title])
