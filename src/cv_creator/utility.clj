(ns cv-creator.utility)

(defn get-language-key [metadata] (keyword (:value (:language metadata))))

(defn- get-ordered-section-keys [metadata] (map keyword (:order metadata)))

(defn get-ordered-sections [metadata content] (mapv #(get content %) (get-ordered-section-keys metadata)))

(defn not-nil? [x] (not (nil? x)))

(defn update-if-exist [aMap key f]
  (if (nil? (key aMap)) aMap (update aMap key f)))
