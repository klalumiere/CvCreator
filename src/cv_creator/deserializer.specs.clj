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
(spec/def :cv-creator.deserializer.education/subitems (spec/coll-of ::deserializer/educationSubitem :kind vector?))
(spec/def ::deserializer/language (spec/keys
                                   :req-un [::deserializer/label ::deserializer/value]))
(spec/def ::deserializer/optionalCoursesSubitem (spec/keys
                                                 :req-un [::deserializer/place ::deserializer/title]
                                                 :opt-un [::deserializer/tags]))
(spec/def :cv-creator.deserializer.optional-courses/subitems (spec/coll-of ::deserializer/optionalCoursesSubitem :kind vector?))
(spec/def ::deserializer/order (spec/coll-of string? :kind vector?))
(spec/def ::deserializer/phone (spec/keys
                                :req-un [::deserializer/label ::deserializer/value]))
(spec/def ::deserializer/relevantReadingsSubitem (spec/keys
                                                  :req-un [::deserializer/authors ::deserializer/title]
                                                  :opt-un [::deserializer/tags]))
(spec/def :cv-creator.deserializer.relevant-readings/subitems (spec/coll-of ::deserializer/relevantReadingsSubitem :kind vector?))
(spec/def ::deserializer/simpleSubitem (spec/keys
                                        :req-un [::deserializer/value]
                                        :opt-un [::deserializer/tags]))
(spec/def ::deserializer/webPage (spec/keys
                                  :req-un [::deserializer/label ::deserializer/value]))


(spec/def ::deserializer/subitems (spec/coll-of ::deserializer/simpleSubitem :kind vector?))


(spec/def ::deserializer/educationItem (spec/keys
                                        :req-un [::deserializer/degree ::deserializer/school ::deserializer/date
                                                 :cv-creator.deserializer.education/subitems]
                                        :opt-un [::deserializer/tags]))
(spec/def :cv-creator.deserializer.education/items (spec/coll-of ::deserializer/educationItem :kind vector?))
(spec/def ::deserializer/experienceItem (spec/keys
                                         :req-un [::deserializer/title ::deserializer/business ::deserializer/date
                                                  ::deserializer/subitems]
                                         :opt-un [::deserializer/tags]))
(spec/def :cv-creator.deserializer.experience/items (spec/coll-of ::deserializer/experienceItem :kind vector?))
(spec/def ::deserializer/simpleItem (spec/keys
                                     :req-un [::deserializer/value]
                                     :opt-un [::deserializer/tags ::deserializer/subitems]))
(spec/def ::deserializer/optionalCourses (spec/keys
                                          :req-un [::deserializer/label
                                                   :cv-creator.deserializer.optional-courses/subitems]
                                          :opt-un [::deserializer/tags]))
(spec/def ::deserializer/relevantReadings (spec/keys
                                                 :req-un [::deserializer/label
                                                          :cv-creator.deserializer.relevant-readings/subitems]
                                                 :opt-un [::deserializer/tags]))


(spec/def ::deserializer/items (spec/coll-of ::deserializer/simpleItem :kind vector?))


(spec/def ::deserializer/section (spec/keys
                                  :req-un [::deserializer/label ::deserializer/items]
                                  :opt-un [::deserializer/tags]))


(spec/def ::deserializer/autodidactTraining (spec/keys
                                             :req-un [::deserializer/label]
                                             :opt-un [::deserializer/relevantReadings
                                                      ::deserializer/optionalCourses ::deserializer/tags]))
(spec/def ::deserializer/contributedTalks ::deserializer/section)
(spec/def ::deserializer/education (spec/keys
                                    :req-un [::deserializer/label :cv-creator.deserializer.education/items]
                                    :opt-un [::deserializer/tags]))
(spec/def ::deserializer/experiences (spec/keys
                                      :req-un [::deserializer/label :cv-creator.deserializer.experience/items]
                                      :opt-un [::deserializer/tags]))
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
