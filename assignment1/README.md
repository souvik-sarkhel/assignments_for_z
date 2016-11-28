#Command to build the image from Dockerfile
sudo docker build -t assignment:1 .
#Command to run container
sudo docker run -d -p 7080:8080 --ulimit nofile=64000:64000 --ulimit nproc=64000:64000 assignment:1
