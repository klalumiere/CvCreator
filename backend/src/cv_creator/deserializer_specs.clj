(ns cv-creator.deserializer-specs
  (:require
   [clojure.spec.alpha :as spec]

   [cv-creator.deserializer]))

(spec/def ::addressDoor (spec/nilable string?))
(spec/def ::addressTown string?)
(spec/def ::authors string?)
(spec/def ::business string?)
(spec/def ::date string?)
(spec/def ::default (spec/nilable boolean?))
(spec/def ::degree string?)
(spec/def ::detailedTag (spec/keys :req-un [::value ::label]))
(spec/def ::eMail string?)
(spec/def ::languageLabel string?)
(spec/def ::label string?)
(spec/def ::name string?)
(spec/def ::place string?)
(spec/def ::school string?)
(spec/def ::sectionName cv-creator.deserializer/possible-section-names)
(spec/def ::tags (spec/nilable (spec/coll-of string? :kind vector?)))
(spec/def ::tagsLabel string?)
(spec/def ::title string?)
(spec/def ::value string?)


(spec/def ::educationSubitem (spec/keys
                              :req-un [::label ::value]
                              :opt-un [::tags]))

(spec/def ::language (spec/keys
                      :req-un [::label ::value]))

(spec/def ::optionalCoursesSubitem (spec/keys
                                    :req-un [::place ::title]
                                    :opt-un [::tags]))
(spec/def ::order (spec/coll-of ::sectionName :kind vector?))
(spec/def ::phone (spec/nilable (spec/keys
                                 :req-un [::label ::value])))
(spec/def ::relevantReadingsSubitem (spec/keys
                                     :req-un [::authors ::title]
                                     :opt-un [::tags]))
(spec/def ::simpleSubitem (spec/keys
                           :req-un [::value]
                           :opt-un [::tags]))
(spec/def ::webPage (spec/keys
                     :req-un [::label ::value]))
(spec/def :cv-creator.deserializer.specs.education/subitems
  (spec/nilable (spec/coll-of ::educationSubitem :kind vector?)))
(spec/def :cv-creator.deserializer.specs.metadata/tags
  (spec/coll-of ::detailedTag :kind vector?))
(spec/def :cv-creator.deserializer.specs.optional-courses/subitems
  (spec/coll-of ::optionalCoursesSubitem :kind vector?))
(spec/def :cv-creator.deserializer.specs.relevant-readings/subitems
  (spec/coll-of ::relevantReadingsSubitem :kind vector?))


(spec/def ::subitems (spec/nilable (spec/coll-of ::simpleSubitem :kind vector?)))


(spec/def ::educationItem (spec/keys
                           :req-un [::degree ::school ::date
                                    :cv-creator.deserializer.specs.education/subitems]
                           :opt-un [::tags]))
(spec/def ::experienceItem (spec/keys
                            :req-un [::title ::business ::date
                                     ::subitems]
                            :opt-un [::tags]))
(spec/def ::optionalCourses (spec/keys
                             :req-un [::label
                                      :cv-creator.deserializer.specs.optional-courses/subitems]
                             :opt-un [::tags]))
(spec/def ::relevantReadings (spec/keys
                              :req-un [::label
                                       :cv-creator.deserializer.specs.relevant-readings/subitems]
                              :opt-un [::tags]))
(spec/def ::simpleItem (spec/keys
                        :req-un [::value]
                        :opt-un [::tags ::subitems]))
(spec/def :cv-creator.deserializer.specs.education/items (spec/coll-of ::educationItem :kind vector?))
(spec/def :cv-creator.deserializer.specs.experience/items (spec/coll-of ::experienceItem :kind vector?))


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
(spec/def ::metadata (spec/keys :req-un [::language
                                         ::languageLabel
                                         ::order
                                         ::tagsLabel
                                         :cv-creator.deserializer.specs.metadata/tags]
                                :opt-un [::default]))
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


(spec/def ::cvJsonArgs (spec/cat :cvJson ::cvJson))
(spec/def ::sections (spec/coll-of any? :kind vector?))


(spec/def ::cv-localized (spec/keys :req-un [::languageLabel
                                             ::label
                                             ::sections
                                             ::tagsLabel
                                             :cv-creator.deserializer.specs.metadata/tags]
                                    :opt-un [::default]))


(spec/def ::cv (spec/map-of keyword? ::cv-localized))
(spec/def ::deserializeCvFn (fn [{:keys [args ret]}]
                              (let [orderCount (count (((args :cvJson) :metadata) :order))]
                                (->>
                                 (map (fn [[_ value]] value) ret)
                                 (map :sections)
                                 (map count)
                                 (every? (fn [x] (= x orderCount)))))))


(spec/fdef cv-creator.deserializer/deserialize-cv
  :args ::cvJsonArgs
  :ret ::cv
  :fn ::deserializeCvFn)
