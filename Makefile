include credentials.mk

build_dir := wehrend.github.io

up:
	hugo serve --disableFastRender --renderStaticToDisk --ignoreCache --config ./content/config.toml

deployment:
	@echo "Building site..."
	hugo -D -d $(build_dir) --config ./content/config.toml
	@echo "Changing directory to output folder..."
	@cd $(build_dir) && \
	if [ -n "$$(git status --porcelain)" ]; then \
		echo "Adding changes..."; \
		git add .; \
		read -p "Enter commit message: " COMMIT_MSG; \
		echo "Committing changes..."; \
		git commit -m "$$COMMIT_MSG"; \
		echo "Pushing to GitHub via SSH with credentials..."; \
		git push -u origin main; \
	else \
		echo "No changes to commit."; \
	fi


cleanup:
	@echo "Cleaning up..."
	rm -rf ./wehrend.github.io
	@echo "Cleanup complete."
