# About Project Name

Project description...

## Makefile Commands

A Makefile has been included to provide a unified CLI for common development commands.

| Command          | Description                                                                 |
| ---------------- | --------------------------------------------------------------------------- |
| `make build`     | Compiles and bundles all front-end assets for production.                  |
| `make dev`       | Builds front-end assets and starts the development server with Hot Module Replacement (HMR). |
| `make release`   | Run `release-it` to automate versioning, tagging, and publishing processes. |

## Notes

- Any file inside `/src/public` will be copied as is to `/web/dist`
