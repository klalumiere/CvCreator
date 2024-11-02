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
- [x] Implement tag filtering
    - [x] for sections
    - [x] for items
    - [x] for subitems
- [x] Verify if there's things I should know about Clojure before deploying all of this in production
    - [x] Like putting environment var to some value to prevent stack trace
    - [x] Read https://github.com/weavejester/lein-ring
- [x] Update server
    - [x] Validate language
    - [x] Validate tags
    - [x] Code review & refactoring
- [x] Reorganize order of function using `declare`
- [x] Add a function to obtain menu content

## Frontend

- [x] Reimplement frontend with modern/simple web framework
    - [x] Choose frontend framework (create-react-app?) and create the app
    - [x] Reimplement index.html
    - [x] Reimplement frontend
    - [x] Add tests
        - [x] Run tests in CI
    - [x] Package and test frontend in prod
        - [x] Set `CV_CREATOR_CROSS_ORIGIN` and `CV_CREATOR_DATA_DIR_PATH`
        - [x] Run packaging tests in CI
    - [x] Minimize java memory footprint as explained in `Dockerfile`, or...
        - [x] Update the misleading comment in the `Dockerfile` since we are now using 512 MB machines in `fly.toml` (also update `-Xmx32M`)
    - [x] Handle vulnerabilities
        - [x] Remove dependencies that are not 100% necessary to the project (see `README.md` about `npm run eject`)
- [x] Spend time understanding the frontend "infra"

## Update data

- [x] Translate my CV in json
- [x] Validate my author data in the CI
- [ ] Make sure I want every empty sections that remains when I remove every tags
- [ ] Sort tags in same order they appear in metadata?
- [ ] Align sections better so that the date on the right end side aligns with the blue line?
- [ ] Update my CV (add and _remove_ stuff)
- [ ] Switch to `CV_CREATOR_DATA_DIR_PATH = "data/author"` in `fly.toml`.
- [ ] Fix menu on top of screen when we scroll?

## Cleanup

- [ ] Remove Ruby and other unused files
- [ ] Update README.md
