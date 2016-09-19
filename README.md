
### Prerequisites

* VirtualBox  
* Vagrant  
* Ansible  
* Git 

add hosts to /etc/hosts 
  
``
192.168.50.4 dev staging
``

### how to run

 - clone this repo  
 - vagrant up



### brief of solution  

using ansible as a provision tool  

  - install jekyll ruby and depencies
  - configure server meet the need
  - put the solution scripts to server
      
        
python and shell script do the automatic stuff

  - devops.py (make post,add to git,push to github) 
  - utils.py (lib of devops.py)
  - watcher.py (check github repo commits and tags,update ,if needed)
  - jekyllctl.sh (stop/start dev/staging server)

