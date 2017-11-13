'./quickstart' is hugo web document.

'./hugo.sh' is for development task. the script could take one parameter ('dev' or 'staging')

'./ansible.cfg' and './hosts' is defalut configuration for ansible. './ansible.cfg' make ansible use hosts file for inventory and username who connect the web server through ssh service and private key. './hosts' is the web server's attributes

'./Vagrantfile' is for up virtual machine, and map 8080, 8555 port at host to 80, 8555 port at virtual machine.

'./web.yaml' is playbook to deploy web service.

'./deploy.sh' is to get web source code from github for dev and staging environment.

'./nginx.conf' is nginx configruate file for dev and staging.

'./webhook.py' is webhook that received push request from github, which to pull source code.




Tutorial

1. pull source code
git clone git@github.com:*/test-devops.git 

2. install hugo
https://gohugo.io/getting-started/installing/

3. start hugo web service
hugo server -D

4. add a new post and push code
./hugo.sh dev

5. increment the version and push code
./hugo.sh staging

6. start virtual machine
vagrant up

7. deploy web service
ansible-playbook web.yaml

8. add webhook at github
http://virtual_machine_IP_address:8555/getcommitfile

9. check dev & staging web site version
 ./hugo.sh dev
 ./hugo.sh staging