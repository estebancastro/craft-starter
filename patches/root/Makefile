.PHONY: build dev launch release up craft-update

# Default build command
build: up
	@ddev npm run build

# Start the project (if not already started) and run dev
dev: up
	@ddev npm run dev

# Start the project (if not already started) and launch the site
launch: up
	@ddev launch

# Release
release:
	@npm run release

# Craft backup, updates, and clear cache
craft-update:
	@echo "Checking for available Craft and plugin updates...";
	@if ! ddev craft update/info | grep -q "You’re all up to date!"; then \
		echo "Updates found! Proceeding..."; \
		echo "Creating DDEV snapshot (backup)..."; \
		@ddev snapshot; \
		echo "Creating Craft database backup..."; \
		@ddev craft db/backup; \
		echo "Updating Craft CMS and all plugins..."; \
		@ddev craft update all; \
		echo "Clearing Craft caches..."; \
		@ddev craft clear-caches/all; \
		echo "Craft and plugins update complete!"; \
	else \
		echo "No updates available!"; \
		exit 0; \
	fi

# Ensure ddev is started before running any other commands
up:
	@if ! ddev describe | grep -q "OK"; then \
		@ddev start; \
	fi

# Catch-all for any undefined targets (no-op)
%:
	@:
