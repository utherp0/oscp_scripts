systemctl stop docker
cd /var/lib/docker
rm -rf
rm /etc/sysconfig/docker-storage
docker-storage-setup
systemctl start docker
