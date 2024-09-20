# Plan

## Backend

- [x] Implement deserialization
    - [x] Make a utility file.clj with utility functions in it?
    - [x] Test everything
        - [x] test utility
        - [x] test dispatch-deserialization in deserializer.clj
        - [x] test create-* in section.clj
        - [x] test create-cv in core.clj
    - [x] Review the pull request code
- [ ] Vérifier l'intégrité (spec?) de mes données et afficher un message d'erreur genre "Offline" si jamais elles ne sont pas OK.
    Comme ça, mes tests end to end vont "pogner" si mes données sont mauvaises.
- [ ] Pass arguments to the main program
- [ ] Implement tag filtering
- [ ] Verify if there's things I should know about Clojure before deploying all of this in production
    - Like putting environment var to some value to prevent stack trace
- [ ] Update server

## Frontend

- [ ] Reimplement frontend with modern/simple web framework

## Update data

- [ ] Translate my CV in json
- [ ] Update my CV
