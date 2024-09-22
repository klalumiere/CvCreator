(ns cv-creator.deserializer.specs
  (:require
   [clojure.spec.alpha :as spec]
   [cv-creator.deserializer :as deserializer]))

(spec/def ::deserializer/addressDoor string?)
(spec/def ::deserializer/addressTown string?)
(spec/def ::deserializer/business string?)
(spec/def ::deserializer/date string?)
(spec/def ::deserializer/degree string?)
(spec/def ::deserializer/eMail string?)
(spec/def ::deserializer/label string?)
(spec/def ::deserializer/name string?)
(spec/def ::deserializer/school string?)
(spec/def ::deserializer/title string?)
(spec/def ::deserializer/tags (spec/coll-of string? :kind vector?))
(spec/def ::deserializer/value string?)

(spec/def ::deserializer/educationSubitem (spec/keys
                                           :req-un [::deserializer/label ::deserializer/value]
                                           :opt-un [::deserializer/tags]))
(spec/def ::deserializer/educationSubitems (spec/coll-of ::deserializer/educationSubitem :kind vector?))
(spec/def ::deserializer/phone (spec/keys
                                           :req-un [::deserializer/label ::deserializer/value]))
(spec/def ::deserializer/subitem (spec/keys
                                             :req-un [::deserializer/value]
                                             :opt-un [::deserializer/tags]))
(spec/def ::deserializer/subitems (spec/coll-of ::deserializer/subitem :kind vector?))
(spec/def ::deserializer/webPage (spec/keys
                                             :req-un [::deserializer/label ::deserializer/value]))


(spec/def ::deserializer/educationItem (spec/keys
                                        :req-un [::deserializer/degree ::deserializer/school ::deserializer/date
                                                 ::deserializer/educationSubitems]
                                        :opt-un [::deserializer/tags]))
(spec/def ::deserializer/educationItems (spec/coll-of ::deserializer/educationItem :kind vector?))
(spec/def ::deserializer/experienceItem (spec/keys
                                         :req-un [::deserializer/title ::deserializer/business ::deserializer/date
                                                  ::deserializer/subitems]
                                         :opt-un [::deserializer/tags]))
(spec/def ::deserializer/experienceItems (spec/coll-of ::deserializer/experienceItem :kind vector?))
(spec/def ::deserializer/item (spec/keys
                                          :req-un [::deserializer/value]
                                          :opt-un [::deserializer/tags ::deserializer/subitems]))
(spec/def ::deserializer/items (spec/coll-of ::deserializer/item :kind vector?))
(spec/def ::deserializer/language (spec/keys
                                              :req-un [::deserializer/label ::deserializer/value]))
(spec/def ::deserializer/order (spec/coll-of string? :kind vector?))


(spec/def ::deserializer/section (spec/keys
                                  :req-un [::deserializer/label ::deserializer/items]
                                  :opt-un [::deserializer/tags]))


(spec/def ::deserializer/education (spec/keys
                                           :req-un [::deserializer/label ::deserializer/educationItems]
                                           :opt-un [::deserializer/tags]))
(spec/def ::deserializer/head (spec/keys
                                          :req-un [::deserializer/name
                                                   ::deserializer/eMail
                                                   ::deserializer/addressTown]
                                          :opt-un [::deserializer/addressDoor
                                                   ::deserializer/phone
                                                   ::deserializer/webPage]))
(spec/def ::deserializer/metadata (spec/keys
                                              :req-un [::deserializer/language ::deserializer/order]))



(spec/def ::deserializer/experiences (spec/keys
                                           :req-un [::deserializer/label ::deserializer/educationItems]
                                           :opt-un [::deserializer/tags]))



;; {


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
