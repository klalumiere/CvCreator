(ns cv-creator.deserializer-specs
  (:require
   [clojure.spec.alpha :as spec]

   [cv-creator.deserializer]))

(spec/def ::addressDoor string?)
(spec/def ::addressTown string?)
(spec/def ::authors string?)
(spec/def ::business string?)
(spec/def ::date string?)
(spec/def ::degree string?)
(spec/def ::eMail string?)
(spec/def ::label string?)
(spec/def ::name string?)
(spec/def ::place string?)
(spec/def ::school string?)
(spec/def ::title string?)
(spec/def ::tags (spec/coll-of string? :kind vector?))
(spec/def ::value string?)


(spec/def ::educationSubitem (spec/keys
                              :req-un [::label ::value]
                              :opt-un [::tags]))
(spec/def :cv-creator.deserializer.specs.education/subitems (spec/coll-of ::educationSubitem :kind vector?))
(spec/def ::language (spec/keys
                      :req-un [::label ::value]))
(spec/def ::optionalCoursesSubitem (spec/keys
                                    :req-un [::place ::title]
                                    :opt-un [::tags]))
(spec/def :cv-creator.deserializer.specs.optional-courses/subitems (spec/coll-of ::optionalCoursesSubitem :kind vector?))
(spec/def ::order (spec/coll-of string? :kind vector?))
(spec/def ::phone (spec/keys
                   :req-un [::label ::value]))
(spec/def ::relevantReadingsSubitem (spec/keys
                                     :req-un [::authors ::title]
                                     :opt-un [::tags]))
(spec/def :cv-creator.deserializer.specs.relevant-readings/subitems (spec/coll-of ::relevantReadingsSubitem :kind vector?))
(spec/def ::simpleSubitem (spec/keys
                           :req-un [::value]
                           :opt-un [::tags]))
(spec/def ::webPage (spec/keys
                     :req-un [::label ::value]))


(spec/def ::subitems (spec/coll-of ::simpleSubitem :kind vector?))


(spec/def ::educationItem (spec/keys
                           :req-un [::degree ::school ::date
                                    :cv-creator.deserializer.specs.education/subitems]
                           :opt-un [::tags]))
(spec/def :cv-creator.deserializer.specs.education/items (spec/coll-of ::educationItem :kind vector?))
(spec/def ::experienceItem (spec/keys
                            :req-un [::title ::business ::date
                                     ::subitems]
                            :opt-un [::tags]))
(spec/def :cv-creator.deserializer.specs.experience/items (spec/coll-of ::experienceItem :kind vector?))
(spec/def ::simpleItem (spec/keys
                        :req-un [::value]
                        :opt-un [::tags ::subitems]))
(spec/def ::optionalCourses (spec/keys
                             :req-un [::label
                                      :cv-creator.deserializer.specs.optional-courses/subitems]
                             :opt-un [::tags]))
(spec/def ::relevantReadings (spec/keys
                              :req-un [::label
                                       :cv-creator.deserializer.specs.relevant-readings/subitems]
                              :opt-un [::tags]))


(spec/def ::items (spec/coll-of ::simpleItem :kind vector?))


(spec/def ::section (spec/keys
                     :req-un [::label ::items]
                     :opt-un [::tags]))


(spec/def ::autodidactTraining (spec/keys
                                :req-un [::label]
                                :opt-un [::relevantReadings
                                         ::optionalCourses ::tags]))
(spec/def ::contributedTalks ::section)
(spec/def ::education (spec/keys
                       :req-un [::label :cv-creator.deserializer.specs.education/items]
                       :opt-un [::tags]))
(spec/def ::experiences (spec/keys
                         :req-un [::label :cv-creator.deserializer.specs.experience/items]
                         :opt-un [::tags]))
(spec/def ::head (spec/keys
                  :req-un [::name
                           ::eMail
                           ::addressTown]
                  :opt-un [::addressDoor
                           ::phone
                           ::webPage]))
(spec/def ::honors ::section)
(spec/def ::metadata (spec/keys :req-un [::language ::order]))
(spec/def ::publications ::section)
(spec/def ::skillSummary ::section)
(spec/def ::socialImplications ::section)


(spec/def ::cvJson (spec/keys
                    :req-un [::metadata ::head]
                    :opt-un [::autodidactTraining
                             ::contributedTalks
                             ::education
                             ::experiences
                             ::honors
                             ::publications
                             ::skillSummary
                             ::socialImplications]))


(spec/fdef cv-creator.deserializer/deserialize-cv :args ::cvJson)
