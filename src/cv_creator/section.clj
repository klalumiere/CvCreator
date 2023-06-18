(ns cv-creator.section)

(defrecord Section [label items tag])

(defrecord HeadSection [name
                        e-mail
                        address-door
                        address-town
                        web-page
                        phone])


(defrecord Item [item subitems tag])

(defrecord EducationItem [degree school date subitems])
(defrecord PhoneItem [label item])
(defrecord SubitemEducation [label subitem])
(defrecord WebPageItem [label item])
