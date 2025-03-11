.PHONY: build dev release up

# Start DDEV (if not already running) and execute 'npm run build' for the build task
build: up
	@ddev npm run build

# Start DDEV (if not already running) and execute 'npm run dev' for development
dev: up
	@ddev npm run dev

# Execute the release task (no DDEV needed as it's a local task)
release:
	@npm run release

# Ensure DDEV is running before executing any other tasks
up:
	@if ! ddev describe | grep -q "OK"; then \
		ddev start; \
	fi

# Catch-all rule to prevent Make from treating extra arguments as targets
%:
	@:
