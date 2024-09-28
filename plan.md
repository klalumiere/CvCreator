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
- [x] Use Specifications to verify data in end to end tests with `sample_data_*.json` and my real data.
    - [x] Instrument the function `deserialize-cv` in end to end tests.
    - [x] Test (with generative function testing) `deserialize-cv`.
- [x] Pass arguments to the main program
    - [x] Test we can select the language (between english and french with the sample)
    - [x] Update sample data in french
- [ ] Implement tag filtering
    - [x] for sections
    - [ ] for items
    - [ ] for subitems
- [ ] Verify if there's things I should know about Clojure before deploying all of this in production
    - Like putting environment var to some value to prevent stack trace
- [ ] Update server
    - [ ] Validate every arguments (including language and tags)

## Frontend

- [ ] Reimplement frontend with modern/simple web framework

## Update data

- [ ] Translate my CV in json
- [ ] Update my CV

## Cleanup

- [ ] Remove Ruby and other unused files
- [ ] Update README.md
