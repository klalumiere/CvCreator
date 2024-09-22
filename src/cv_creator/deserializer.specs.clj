(ns cv-creator.deserializer.specs
  (:require
   [clojure.spec.alpha :as spec]
   [cv-creator.deserializer :as deserializer]))

(spec/def ::deserializer/addressDoor string?)
(spec/def ::deserializer/addressTown string?)
(spec/def ::deserializer/authors string?)
(spec/def ::deserializer/business string?)
(spec/def ::deserializer/date string?)
(spec/def ::deserializer/degree string?)
(spec/def ::deserializer/eMail string?)
(spec/def ::deserializer/label string?)
(spec/def ::deserializer/name string?)
(spec/def ::deserializer/place string?)
(spec/def ::deserializer/school string?)
(spec/def ::deserializer/title string?)
(spec/def ::deserializer/tags (spec/coll-of string? :kind vector?))
(spec/def ::deserializer/value string?)


(spec/def ::deserializer/educationSubitem (spec/keys
                                           :req-un [::deserializer/label ::deserializer/value]
                                           :opt-un [::deserializer/tags]))
(spec/def ::deserializer/educationSubitems (spec/coll-of ::deserializer/educationSubitem :kind vector?))
(spec/def ::deserializer/language (spec/keys
                                   :req-un [::deserializer/label ::deserializer/value]))
(spec/def ::deserializer/optionalCoursesSubitem (spec/keys
                                                 :req-un [::deserializer/place ::deserializer/title]
                                                 :opt-un [::deserializer/tags]))
(spec/def ::deserializer/optionalCoursesSubitems (spec/coll-of ::deserializer/optionalCoursesSubitem :kind vector?))
(spec/def ::deserializer/order (spec/coll-of string? :kind vector?))
(spec/def ::deserializer/phone (spec/keys
                                :req-un [::deserializer/label ::deserializer/value]))
(spec/def ::deserializer/relevantReadingsSubitem (spec/keys
                                                  :req-un [::deserializer/authors ::deserializer/title]
                                                  :opt-un [::deserializer/tags]))
(spec/def ::deserializer/relevantReadingsSubitems (spec/coll-of ::deserializer/relevantReadingsSubitem :kind vector?))
(spec/def ::deserializer/simpleSubitem (spec/keys
                                        :req-un [::deserializer/value]
                                        :opt-un [::deserializer/tags]))
(spec/def ::deserializer/simpleSubitems (spec/coll-of ::deserializer/simpleSubitem :kind vector?))
(spec/def ::deserializer/webPage (spec/keys
                                  :req-un [::deserializer/label ::deserializer/value]))


(spec/def ::deserializer/subitems (spec/or
                                   ::deserializer/educationSubitems
                                   ::deserializer/optionalCoursesSubitems
                                   ::deserializer/relevantReadingsSubitems
                                   ::deserializer/simpleSubitems))


(spec/def ::deserializer/autodidactTrainingItem (spec/keys
                                                 :req-un [::deserializer/label ::deserializer/subitems]
                                                 :opt-un [::deserializer/tags]))
(spec/def ::deserializer/educationItem (spec/keys
                                        :req-un [::deserializer/degree ::deserializer/school ::deserializer/date
                                                 ::deserializer/subitems]
                                        :opt-un [::deserializer/tags]))
(spec/def ::deserializer/educationItems (spec/coll-of ::deserializer/educationItem :kind vector?))
(spec/def ::deserializer/experienceItem (spec/keys
                                         :req-un [::deserializer/title ::deserializer/business ::deserializer/date
                                                  ::deserializer/subitems]
                                         :opt-un [::deserializer/tags]))
(spec/def ::deserializer/experienceItems (spec/coll-of ::deserializer/experienceItem :kind vector?))
(spec/def ::deserializer/simpleItem (spec/keys
                                     :req-un [::deserializer/value]
                                     :opt-un [::deserializer/tags ::deserializer/subitems]))
(spec/def ::deserializer/simpleItems (spec/coll-of ::deserializer/simpleItem :kind vector?))


(spec/def ::deserializer/items (spec/or ::deserializer/educationItems ::deserializer/experienceItems
                                        ::deserializer/simpleItems))
(spec/def ::deserializer/relevantReadings ::deserializer/autodidactTrainingItem)
(spec/def ::deserializer/optionalCourses ::deserializer/autodidactTrainingItem)


(spec/def ::deserializer/section (spec/keys
                                  :req-un [::deserializer/label ::deserializer/items]
                                  :opt-un [::deserializer/tags]))


(spec/def ::deserializer/autodidactTraining (spec/keys
                                             :req-un [::deserializer/label]
                                             :opt-un [::deserializer/relevantReadings
                                                      ::deserializer/optionalCourses ::deserializer/tags]))
(spec/def ::deserializer/contributedTalks ::deserializer/section)
(spec/def ::deserializer/education ::deserializer/section)
(spec/def ::deserializer/experiences ::deserializer/section)
(spec/def ::deserializer/head (spec/keys
                               :req-un [::deserializer/name
                                        ::deserializer/eMail
                                        ::deserializer/addressTown]
                               :opt-un [::deserializer/addressDoor
                                        ::deserializer/phone
                                        ::deserializer/webPage]))
(spec/def ::deserializer/honors ::deserializer/section)
(spec/def ::deserializer/metadata (spec/keys :req-un [::deserializer/language ::deserializer/order]))
(spec/def ::deserializer/publications ::deserializer/section)
(spec/def ::deserializer/skillSummary ::deserializer/section)
(spec/def ::deserializer/socialImplications ::deserializer/section)
