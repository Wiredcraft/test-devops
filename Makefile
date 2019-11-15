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

# python management
actibate_venv:
	. .venv/bin/activate

# site generator
hugo_new_post:
	cd website && export NEW_POST_PATH=posts/post-at-$$(date '+%Y-%m-%d-%s').md && hugo new $${NEW_POST_PATH} && fortune >> content/$${NEW_POST_PATH}

hogo_build_dev:
	cd website && hugo -D -b dev.devopstest.com && cd .. && git add . && git commit -m "Automatic dev post at $$(date '+%Y-%m-%d-%s')" && git push origin

hogo_build_stage:
	cd website && hugo -D -b stage.devopstest.com && cd .. && git add . && git commit -m "Automatic stage post at $$(date '+%Y-%m-%d-%s')" && git tag $${TAG} && git push origin --tags && git push origin