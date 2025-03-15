
# ~/development/hugo/blog#

up:
	hugo serve --disableFastRender --renderStaticToDisk --ignoreCache --config ./content/config.toml

# Deployment-Prozess mit besserem Fehler-Handling
deployment:
	@echo "Building site..."
	hugo -D -d ./wehrend.github.io --config ./content/config.toml
	@if [ -n "$$(git status --porcelain)" ]; then \
		echo "Adding changes..."; \
		git add .; \
		echo "Committing changes..."; \
		git commit -m "Deploying to GitHub Pages"; \
		echo "Pushing to GitHub..."; \
		git push origin main; \
	else \
		echo "No changes to commit."; \
	fi

cleanup:
	@echo "Cleaning up..."
	rm -rf ./wehrend.github.io
	@echo "Cleanup complete."
