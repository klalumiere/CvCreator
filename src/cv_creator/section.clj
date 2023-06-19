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
(defrecord ExperienceItem [title business date subitems tags])
(defrecord PhoneItem [label item])
(defrecord SubitemEducation [label subitem])
(defrecord SubitemOptionalCourses [title place tags])
(defrecord SubitemRelevantReadings [authors title tags])
(defrecord WebPageItem [label item])
