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

.PHONY: actibate_venv box_init box_up box_down box_ssh