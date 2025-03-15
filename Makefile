
# ~/development/hugo/blog#
include credentials.mk

up:
	hugo serve --disableFastRender --renderStaticToDisk --ignoreCache --config ./content/config.toml

deployment:
	@echo "Building site..."
	hugo -D -d ./wehrend.github.io --config ./content/config.toml
	@if [ -n "$$(git status --porcelain)" ]; then \
		echo "Adding changes..."; \
		git add .; \
		read -p "Enter commit message: " COMMIT_MSG; \
		echo "Committing changes..."; \
		git commit -m "$$COMMIT_MSG"; \
		echo "Pushing to GitHub..."; \
		git push https://$(GIT_USER):$(GIT_PASS)@github.com/wehrend/hugo_blog.git main; \
	else \
		echo "No changes to commit."; \
	fi


cleanup:
	@echo "Cleaning up..."
	rm -rf ./wehrend.github.io
	@echo "Cleanup complete."
