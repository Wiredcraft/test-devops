box_up:
	cd vagrant_box && vagrant up

box_down:
	cd vagrant_box && vagrant halt

box_ssh:
	cd vagrant_box && vagrant ssh

actibate_venv:
	. .venv/bin/activate

box_init:
	make actibate_venv && cd ansible && ansible-playbook -i inventory server_spawn.yml --tags=init,nginx

hugo_new_post:
	cd website && export NEW_POST_PATH=posts/post-at-$$(date '+%Y-%m-%d-%s').md && hugo new $${NEW_POST_PATH} && fortune >> content/$${NEW_POST_PATH}

.PHONY: actibate_venv box_init box_up box_down box_ssh hugo_new_post