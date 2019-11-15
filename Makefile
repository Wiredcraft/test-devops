# vagrant management
box_create:
	make box_up && cd vagrant_box && /bin/bash ./box_post_create.sh 

box_up:
	cd vagrant_box && vagrant up

box_down:
	cd vagrant_box && vagrant halt

box_ssh:
	cd vagrant_box && vagrant ssh

box_init:
	make actibate_venv && cd ansible && ansible-playbook -i inventory server_spawn.yml --tags=init,ngin,ssh_git,ansible

box_init_crontabs:
	make actibate_venv && cd ansible && ansible-playbook -i inventory server_crontabs.yml --tags=push

# management
actibate_venv:
	. .venv/bin/activate

git_update_local:
	git fetch origin && git merge origin/ilya/homework

# site generator
hugo_new_post:
	cd website && export NEW_POST_PATH=posts/post-at-$$(date '+%Y-%m-%d-%s').md && hugo new $${NEW_POST_PATH} && fortune >> content/$${NEW_POST_PATH}

hugo_compile:
	cd website && hugo -D -b $${ENV}.devopstest.com && cd ..

hogo_build_dev:
	make git_update_local && make hugo_compile ENV=dev && git add . && git commit -m "Automatic dev post at $$(date '+%Y-%m-%d-%s')" && git push origin

hogo_build_stage:
	make git_update_local && make hugo_compile ENV=stage && git add . && git commit -m "Automatic stage post at $$(date '+%Y-%m-%d-%s')" && git tag $${TAG} && git push origin --tags && git push origin