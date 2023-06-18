(ns cv-creator.section)

(defrecord Section [label items tag])
(defrecord HeadSection [name
                        e-mail
                        address-door
                        address-town
                        web-page
                        phone])

(defrecord Item [item subitems tag])
(defrecord WebPageItem [label item])
(defrecord PhoneItem [label item])
