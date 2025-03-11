.PHONY: build dev launch release craft up

# Start DDEV (if not already running) and execute 'npm run build' for the build task
build: up
	@ddev npm run build

# Start DDEV (if not already running) and execute 'npm run dev' for development
dev: up
	@ddev npm run dev

# Start DDEV (if not already running) and launch the local site in the browser
launch: up
	@ddev launch

# Run any Craft CMS command inside the DDEV PHP container
craft:
	@ddev craft $(filter-out $@,$(MAKECMDGOALS))

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
