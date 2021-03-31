# Wiredcraft DevOps - Static website generator and build flow

## Task 1:
  
The script is inside the static website directory, in this example, a directory named "jerrytest".

Script name: postGenerator.sh

Script parameter: env (either "dev" or "staging")

## Task 2:

The Ansible playbook is named: docker-registry-playbook.yml

In order to use it, need to update hostname in the hosts file, and make sure ssh connection to the remote server without password is fine. 

## Task 3:

The Terraform main script is main.tf, and all the variables are defined in the variables.tf

## Task 4:

For the mocker API, I use python flask api to implement a simple http get response.

Then from the Dockerfile it will build and create a docker image on top of the python code.

## Task 5:

Below Kubernetes objects are created: Service, Deployment and HPA.

For the service, I assume we are using NodePort for simplicity but in production we should be using ingress.

## Task 6:

The github action config file was created under: .github/workflows