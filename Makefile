WORKDIR:=${pwd}
SITEDIR:=./site
HTMLDIR:=${SITEDIR}/public
DEPLOYDIR:=/var/www
SERVER_IP:=${SERVER_IP}
TERRAFORM_DIR:=./terraform
SSH_USER:=root
SSH_PUBLIC_KEY:=id_rsa.pub
SSH_FINGERPRINT:=$(shell ssh-keygen -E md5 -lf ${SSH_PUBLIC_KEY} | awk '{print $$2}' | tail -c +5)

init:
	terraform init ${TERRAFORM_DIR}

create-ssh-key:
	./cli/create_ssh_key.sh

create-server:
	echo "create server..."
	terraform apply -auto-approve -var do_token=${DO_TOKEN} -var ssh_fingerprint=${SSH_FINGERPRINT} ${TERRAFORM_DIR}

destroy-server:
	echo "destroy server..."
	terraform destroy -auto-approve -var do_token=${DO_TOKEN} -var ssh_fingerprint=${SSH_FINGERPRINT} ${TERRAFORM_DIR}

upgrade-dev:
	echo upgrade-dev

upgrade-staging:
	echo upgrade-staging

deploy-dev:
	./cli/ci.sh
	ansible-playbook -u ${SSH_USER} --private-key id_rsa -i ./ansible/inventory.cfg ./ansible/deploy-dev.yml

deploy-staging:
	./cli/ci.sh
	ansible-playbook -u ${SSH_USER} --private-key id_rsa -i ./ansible/inventory.cfg ./ansible/deploy-staging.yml
