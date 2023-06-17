(ns cv-creator.section)

(defrecord Section [label items])
(defrecord HeadSection [name
                        e-mail
                        address-door
                        address-town
                        web-page
                        phone])

(defrecord Item [item tag])
(defrecord WebPageItem [label item])
(defrecord MobileItem [label item])
