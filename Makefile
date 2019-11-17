.DEFAULT_GOAL:=help
SHELL:=/bin/bash

##@ Vagrant

.PHONY: box_create box_up box_down box_ssh box_init box_init_crontabs

box_create: ## Create vagrant box and add it's ssh key and configuration to ~/.ssh/
	make box_up && cd vagrant_box && /bin/bash ./box_post_create.sh 

box_up: ## Start the box
	cd vagrant_box && vagrant up

box_down: ## Halt the box
	cd vagrant_box && vagrant halt

box_ssh: ## Connect to the box via ssh 
	cd vagrant_box && vagrant ssh

box_init: ## Spawn the box installing needed software and init dev and stage websites 
	make actibate_venv && cd ansible && ansible-playbook -i inventory server_spawn.yml --tags=init,nginx,ssh_git

box_init_crontabs: ## Add crontabs to make and check the changes
	make actibate_venv && cd ansible && ansible-playbook -i inventory server_crontabs.yml --tags=push,pull

##@ Management 

.PHONY: actibate_venv git_update_local

actibate_venv: ## Activate python virtual environment
	. .venv/bin/activate

git_update_local: ## Update local git repo
	git fetch origin && git merge origin/ilya/homework

##@ HOGO site generator 

.PHONY: hugo_new_post hugo_compile hogo_build_dev hogo_build_stage

hugo_new_post: ## Create new post
	cd website && export NEW_POST_PATH=posts/post-at-$$(date '+%Y-%m-%d-%s').md && hugo new $${NEW_POST_PATH} && fortune >> content/$${NEW_POST_PATH}

hugo_compile: ## Compile the website. Usage: make hugo_compile <ENV> (ENV: stage or dev)
	cd website && hugo -D -b http://$${ENV}.devopstest.com/ && cd ..

hogo_build_dev: ## Build new dev version and push it to git
	make git_update_local && make hugo_compile ENV=dev && git add . && git commit -m "Automatic dev post at $$(date '+%Y-%m-%d-%s')" && git push origin

hogo_build_stage: ## Build new stage version and push it to git
	make git_update_local && make hugo_compile ENV=stage && git add . && git commit -m "Automatic stage post at $$(date '+%Y-%m-%d-%s')" && git tag $${TAG} && git push origin --tags && git push origin


##@ Helpers

.PHONY: help

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)