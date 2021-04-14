Here is my result for the devops test.
https://github.com/wiredcraft/test-devops/tree/modular-test

Task1:
For this task, we assume we already install hugo/fortune/git in our system and we already create a website through command 'hugo new site website-demo'. Then we download a theme from hugo and create a repo for this website.
Then we can run the shell script to create a now content for this website.

sh create_content.sh contentName

The parameter contentName will be used as the name of the content file. It will generate a new content file with the given name through command 'hugo new contentName.cd'.
Then the shell script will remove the text 'draft:true' and add a text generate by fortune into the content file.

Task2:
For this task, we prepare 2 config file to initial setup of the server and deployment of private Docker registry service through the tool ansible. As there is only one server, we just install the tool yum and sync the system time in the initial step.
We did not set the hostname and iptables this time. If there is any other tools need to be installed or any other config need to be set. We will add it later.  
The server ssh connect related information is in the host file and what the ansible tool need to do step by step is set in the test.yaml file. Each step has an annotation in the yaml file.We won't explain them again here.
You cna put the 2 files in the right directory in the catalogue of ansible and then run ansible command.

ansible-playbook test.yml


Task3:
For this task, we will create an instance in AWS cloud through terraform. We assume we already have an account in the AWS cloud and we also generate a key pair.
1.We will config the key pair, the key pair is set in the config.tf file.
terraform init

2.We will create a VPC in this step, the VPC related information is set in the VPC.tf
terraform applay

3.After the VPC is created successfully, we need to login to the AWS and get the VPC iD, then we can set the subnet for the VPC. The subnet related information is set in the sn.tf file.
terraform applay

4.If all of the above step is done successfully. We can create an EC2 instance. The related information is in the ec2.tf file.
terraform applay

Task4:
For this task, we have provide some restful API and the source code is in the main.go file. It is wrote in golang and we build it to make it can be run in Linux ENV.
In order to test this API directly through postman, we store the data in a hash map instaed of a database.
We also create a Dockerfile to containerize the API.

Task5:
For this task, we try to deploy the API in a K8S cluster. We assume the Dockerfile is build into a docker image through command 'docker build -t test-API .'
Then we config the deployment and service, the detail is in the deployment.yaml and service.yaml file. In the deployment file we set the replicas to 2. In the service file we set the clusterIP to None to use DNS instead of VIP.

For the HPA task, as the data is stored in a hashmap instead if in a database. If the hashmap is too big, there will be some problem. So we use the K8S HPA to sutpscall the pod when the data is too big.
We have a restful API to provide the number of user which is store in the hashmap. we assume we have a Prometheus and it has set to get the user number through the restful API we provide.
Then we can get the user number through an URL such as:

https://<apiserver_ip>/apis/custom-metrics.metrics.k8s.io/v1beta1/namespaces/default/pods/test-API/user_number

Then we create a custom Metrics APIserver to get the info from Prometheus.
kubectl apply -f custom-metrics.yaml

The next step we will create a ClusterRoleBinding to user system:anonymous. We will do this through kubectl install to put it the the yaml file to make it more convenient.
kubectl create clusterrolebinding allowall-cm --clusterrole custom-metrics-server-resources --user system:anonymous

At the last step, we will create the HPA.
kubectl apply -f hpa.yaml

Sometimes we need to send a post request to tell the Prometheus we have create a new serviceMoniter.
curl -X POST -v "http://ServerIP:30090/-/reload"

Task6:
For this task, we will create a CI pipeline to do some unit tests for the API from Task 4 on Pull Requests. As the methods in task 4 is just to process the data in a hashmap. It is hard to write
unit test for them. So I prepare another unit test here just for test. Ps. I know this is not rigorous, just for this time.
The action workflow file for this step is the file gotest.yml. We use some github actions to help to set up the golang ENV and checkout the code.

Then we try to build docker image on Pull Request merge. We will use the Docker file we created at task4. The action workflow file goDocker.yml. We also use some actions provided by the docker to help
to set the ENV and build the docker image.

After the image is push to the dockerhub, we try to deploy the application in our standalone server. First we create an action which is defind in file action.yml to connect to a server through ssh.
This action need us to set the username/password for the server in the github for security reason. Then we can send the shell script to the server and deploy the new version of the application. 