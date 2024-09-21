(ns cv-creator.deserializer.specs
  (:require
   [clojure.spec.alpha :as spec]
   [cv-creator.deserializer]))

(spec/def ::cv-creator.deserializer/addressDoor string?)
(spec/def ::cv-creator.deserializer/addressTown string?)
(spec/def ::cv-creator.deserializer/eMail string?)
(spec/def ::cv-creator.deserializer/label string?)
(spec/def ::cv-creator.deserializer/name string?)
(spec/def ::cv-creator.deserializer/tags (spec/coll-of string? :kind vector?))
(spec/def ::cv-creator.deserializer/value string?)

(spec/def ::cv-creator.deserializer/phone (spec/keys
                                           :req-un [::cv-creator.deserializer/label ::cv-creator.deserializer/value]))
(spec/def ::cv-creator.deserializer/subitem (spec/keys
                                             :req-un [::cv-creator.deserializer/value]
                                             :opt-un [::cv-creator.deserializer/tags]))
(spec/def ::cv-creator.deserializer/subitems (spec/coll-of ::cv-creator.deserializer/subitem :kind vector?))
(spec/def ::cv-creator.deserializer/webPage (spec/keys
                                             :req-un [::cv-creator.deserializer/label ::cv-creator.deserializer/value]))


(spec/def ::cv-creator.deserializer/item (spec/keys
                                          :req-un [::cv-creator.deserializer/value]
                                          :opt-un [::cv-creator.deserializer/tags ::cv-creator.deserializer/subitems]))
(spec/def ::cv-creator.deserializer/items (spec/coll-of ::cv-creator.deserializer/item :kind vector?))
(spec/def ::cv-creator.deserializer/language (spec/keys
                                              :req-un [::cv-creator.deserializer/label ::cv-creator.deserializer/value]))
(spec/def ::cv-creator.deserializer/order (spec/coll-of string? :kind vector?))


(spec/def ::cv-creator.deserializer/head (spec/keys
                                          :req-un [::cv-creator.deserializer/name
                                                   ::cv-creator.deserializer/eMail
                                                   ::cv-creator.deserializer/addressTown]
                                          :opt-un [::cv-creator.deserializer/addressDoor
                                                   ::cv-creator.deserializer/phone
                                                   ::cv-creator.deserializer/webPage]))
(spec/def ::cv-creator.deserializer/metadata (spec/keys
                                              :req-un [::cv-creator.deserializer/language ::cv-creator.deserializer/order]))
(spec/def ::cv-creator.deserializer/section (spec/keys
                                             :req-un [::cv-creator.deserializer/label ::cv-creator.deserializer/items]
                                             :opt-un [::cv-creator.deserializer/tags]))


;; {
;;     "education": {
;;         "label": "Education",
;;         "items": [
;;             {
;;                 "degree": "PhD",
;;                 "school": "Université",
;;                 "date": "2010",
;;                 "subitems": [
;;                     {
;;                         "label": "Thesis",
;;                         "value": "How to have fun"
;;                     }
;;                 ]
;;             }
;;         ]
;;     },
;;     "experiences": {
;;         "label": "Experiences",
;;         "items": [
;;             {
;;                 "title": "Graduate student",
;;                 "business": "Alex Térieur, Montreal(Qc), Canada",
;;                 "date": "2008-",
;;                 "subitems": [
;;                     {
;;                         "value": "A PhD"
;;                     }
;;                 ]
;;             }
;;         ]
;;     },
;;     "autodidactTraining": {
;;         "label": "Autodidact training",
;;         "relevantReadings": {
;;             "label": "Relevant readings",
;;             "subitems": [
;;                 {
;;                     "authors": "Titus Winters, Tom Manshreck, Hyrum Wright",
;;                     "title": "Software Engineering at Google: Lessons Learned from Programming Over Time",
;;                     "tags": [
;;                         "computerScience"
;;                     ]
;;                 }
;;             ]
;;         },
;;         "optionalCourses": {
;;             "label": "Optional courses",
;;             "subitems": [
;;                 {
;;                     "place": "Restaurant",
;;                     "title": "Cooking for dummies",
;;                     "tags": [
;;                         "food"
;;                     ]
;;                 }
;;             ]
;;         }
;;     },
;; }
