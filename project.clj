(defproject cv-creator "0.1.0"
  :description "Use data files to generate a CV in many languages with optional entries"
  :url "https://github.com/klalumiere/cvcreator"
  :license {:name "MIT"
            :url "https://mit-license.org/"}
  :dependencies [[org.clojure/clojure "1.11.1"]
                 [ring/ring-core "1.9.6"]
                 [ring/ring-jetty-adapter "1.9.6"]]
  :repl-options {:init-ns cv-creator.core}
  :main cv-creator.core)
