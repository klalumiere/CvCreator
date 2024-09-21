(ns cv-creator.deserializer.specs
  (:require
   [clojure.spec.alpha :as spec]
   [cv-creator.deserializer :as deserializer]))

(spec/def ::deserializer/addressDoor string?)
(spec/def ::deserializer/addressTown string?)
(spec/def ::deserializer/date string?)
(spec/def ::deserializer/degree string?)
(spec/def ::deserializer/eMail string?)
(spec/def ::deserializer/label string?)
(spec/def ::deserializer/name string?)
(spec/def ::deserializer/school string?)
(spec/def ::deserializer/tags (spec/coll-of string? :kind vector?))
(spec/def ::deserializer/value string?)

(spec/def ::deserializer/phone (spec/keys
                                           :req-un [::deserializer/label ::deserializer/value]))
(spec/def ::deserializer/subitem (spec/keys
                                             :req-un [::deserializer/value]
                                             :opt-un [::deserializer/tags]))
(spec/def ::deserializer/subitems (spec/coll-of ::deserializer/subitem :kind vector?))
(spec/def ::deserializer/webPage (spec/keys
                                             :req-un [::deserializer/label ::deserializer/value]))


(spec/def ::deserializer/item (spec/keys
                                          :req-un [::deserializer/value]
                                          :opt-un [::deserializer/tags ::deserializer/subitems]))
(spec/def ::deserializer/items (spec/coll-of ::deserializer/item :kind vector?))
(spec/def ::deserializer/language (spec/keys
                                              :req-un [::deserializer/label ::deserializer/value]))
(spec/def ::deserializer/order (spec/coll-of string? :kind vector?))


(spec/def ::deserializer/head (spec/keys
                                          :req-un [::deserializer/name
                                                   ::deserializer/eMail
                                                   ::deserializer/addressTown]
                                          :opt-un [::deserializer/addressDoor
                                                   ::deserializer/phone
                                                   ::deserializer/webPage]))
(spec/def ::deserializer/metadata (spec/keys
                                              :req-un [::deserializer/language ::deserializer/order]))
(spec/def ::deserializer/section (spec/keys
                                             :req-un [::deserializer/label ::deserializer/items]
                                             :opt-un [::deserializer/tags]))


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
