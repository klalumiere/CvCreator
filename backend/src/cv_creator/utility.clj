(ns cv-creator.utility)
(declare get-ordered-section-keys)

(defn drop-sections [cv] (into {} (map (fn [[key value]] [key (update value :sections (constantly nil))]) cv)))

(defn get-language-key [metadata] (keyword (:value (:language metadata))))

(defn get-language-label [metadata] (:label (:language metadata)))

(defn get-ordered-sections [metadata content] (mapv #(get content %) (get-ordered-section-keys metadata)))

(defn not-nil? [x] (not (nil? x)))

(defn update-if-exist [aMap key f]
  (if (nil? (key aMap)) aMap (update aMap key f)))


(defn- get-ordered-section-keys [metadata] (map keyword (:order metadata)))
