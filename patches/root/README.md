# About Project Name

Project description...

## Makefile Commands

A Makefile has been included to provide a unified CLI for common development commands.

| Command          | Description                                                                 |
| ---------------- | --------------------------------------------------------------------------- |
| `make dev`       | Builds all front-end assets once and starts Vite's server for Hot Module Replacement (HMR). |
| `make build`     | Compiles and bundles all front-end assets for production.                  |
| `make launch`    | Opens the current site in a browser.                                       |
| `make release`   | Runs `release-it` to automate versioning, tagging, and publishing processes. |
| `make craft-update` | Updates Craft CMS and its plugins to the latest version. |

## Notes

- Any file inside `/src/public` will be copied as is to `/web/dist`
