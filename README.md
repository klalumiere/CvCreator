# CvCreator

Use some JSON data files to generate a CV in many languages with optional entries.
Live at <https://cvcreator.fly.dev/>.

## Quick Start

### Development

To start the backend

```shell
cd backend
CV_CREATOR_CROSS_ORIGIN=http://localhost:3000 CV_CREATOR_DATA_DIR_PATH=../data/sample lein ring server
```

and then to start the frontend

```shell
cd frontend
VITE_CV_CREATOR_BACKEND_URL=http://localhost:8080 pnpm start
```

The environment variable `CV_CREATOR_DATA_DIR_PATH` controls the directory searched for JSON data files.
It defaults to `data/sample`.

### Packaged

Run `./launchServer.sh`.

## Command Line

To create a CV from the command line, use the commands

```shell
cd backend
lein run -m cv-creator.core/-main <data-directory-path> <language> <tags>...
```

The data directory needs to contain one or many JSON files (one JSON file per language) that specify the content of the CV.
The valid `<language>` and `<tags>` are specified in the data files.
Tagged sections, items and subitems are excluded unless the tag they contain is passed on the command line.

An example of a valid command is

```shell
cd backend && lein run -m cv-creator.core/-main ../data/sample english computerScience
```

## More

Take a look at the Continuous Integration (CI) in the file [.github/workflows/test.yml](./.github/workflows/test.yml).

## Legacy

The third party package [resources/latexResumeStyleSheet.cls](./resources/latexResumeStyleSheet.cls) provides, as its name suggests, a LaTeX style sheet for CVs.
