.PHONY: build dev launch npm composer craft snapshot release up

# Start DDEV (if not already running) and execute 'npm run build' for the build task
build: up
	@ddev npm run build

# Start DDEV (if not already running) and execute 'npm run dev' for development
dev: up
	@ddev npm run dev

# Start DDEV (if not already running) and launch the local site in the browser
launch: up
	@ddev launch $(filter-out $@,$(MAKECMDGOALS))

# Run any npm command inside the DDEV container
npm: up
	@ddev npm $(filter-out $@,$(MAKECMDGOALS))

# Run any Composer command inside the DDEV container
composer: up
	@ddev composer $(filter-out $@,$(MAKECMDGOALS))

# Run any Craft CMS command inside the DDEV PHP container
craft: up
	@ddev craft $(filter-out $@,$(MAKECMDGOALS))

# Run any Snapshot command inside the DDEV container (e.g., for managing backups)
snapshot: up
	@ddev snapshot $(filter-out $@,$(MAKECMDGOALS))

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
