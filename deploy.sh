if sudo docker ps | grep nodejs-svr1
then
echo "already running"
sudo docker stop nodejs-svr1
sudo docker rm nodejs-svr1
else
sudo docker run -d --name nodejs-svr1 -p 5001:5001 -v mraagil/docker-nodejs
fi