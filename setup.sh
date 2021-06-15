cd /bots

sudo apt update -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update -y
sudo apt install docker-ce
sudo usermod -aG docker ${USER}
su - ${USER}

sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo git clone https://github.com/thinkfiveable/cram-support-bot.git csb
sudo mkdir mm

sudo mv csb.env ./csb/.env
sudo mv mm.env ./mm/.env

cd csb
docker-compose up -d --build
cd ../mm
docker pull kyb3rr/modmail
docker run -d --restart=unless-stopped --env-file .env kyb3rr/modmail