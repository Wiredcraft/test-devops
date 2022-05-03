#Run in the directory where is dockerfile
sudo docker build -t demo:v1
#Run the container
sudo docker run demo:v1
#Load data volume
sudo docker run -v /docker_demo/logs:/logs demo:v1

