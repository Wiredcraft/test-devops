help:
	@echo "There are 5 targets available for this project:"
	@echo "  preflight : checking prerequisite commandline tools."
	@echo "  init      : initialize the blog website."
	@echo "  post      : generate random blog pods, each make will generate a freshly new post."
	@echo "  preview   : preview blog on localhost."
	@echo "  git       : commit changes and push to upstream."

preview:
	@hack/preview.sh

post:
	@hack/post.sh

init: preflight
	@hack/init.sh

preflight:
	@hack/preflight.sh

git:
	@hack/git.sh
