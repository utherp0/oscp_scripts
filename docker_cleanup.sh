sudo docker rm $(sudo docker ps -a | grep Exited | awk '{print $1}')
sudo docker rm $(sudo docker ps -a | grep Dead | awk '{print $1}')
sudo docker rmi $(sudo docker images -qaf 'dangling=true')
