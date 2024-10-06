(defproject cv-creator "0.1.0"
  :description "Use data files to generate a CV in many languages with optional entries"
  :url "https://github.com/klalumiere/cvcreator"
  :license {:name "MIT"
            :url "https://mit-license.org/"}
  :dependencies [[compojure "1.7.0"]
                 [org.clojure/clojure "1.11.1"]
                 [org.clojure/data.json "2.5.0"]
                 [ring/ring-core "1.9.6"]
                 [ring/ring-jetty-adapter "1.9.6"]
                 [ring/ring-json "0.5.1"]
                 [selmer "1.12.58"]]
  :plugins [[lein-ring "0.12.6"]]
  :ring {:handler cv-creator.server/app :port 8080}
  :repl-options {:init-ns cv-creator.server}
  :target-path "target/%s"
  :test-selectors {:default (complement :integration)
                   :integration :integration}
  :profiles {:uberjar {:aot :all :uberjar-name "cv-creator.jar"}
             :test     {:dependencies [[org.clojure/test.check "1.1.1"]]}})
