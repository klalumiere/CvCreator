(ns cv-creator.section)

(defrecord Section [label items tags])

(defrecord HeadSection [name
                        e-mail
                        address-door
                        address-town
                        web-page
                        phone])


(defrecord Item [item subitems tags])

(defrecord AutodidactTrainingItem [label subitems])
(defrecord EducationItem [degree school date subitems])
(defrecord ExperienceItem [title business date subitems])
(defrecord PhoneItem [label item])
(defrecord SubitemEducation [label subitem])
(defrecord SubitemOptionalCourses [title place])
(defrecord SubitemRelevantReadings [authors title])
(defrecord WebPageItem [label item])
