# About Project Name

Project description...

## Makefile Commands

A Makefile has been included to provide a unified CLI for common development commands.

| Command | Description |
| -------- | ------- |
| `make dev` | Runs a one-time build of all front-end assets, then starts Vite's server for HMR. |
| `make build` | Builds all front-end assets. |
| `make launch` | Launch a browser with the current site. |
| `make release` | Runs release-it to automatically. |

## Notes

- Any file inside `/src/public` will be copied as is to `/web/dist`
