#!/bin/sh
cd /bots
printf "\n\nSetting up docker!\n\n"
if [ -x "$(command -v docker)" ]; then
    echo -e "Docker already installed. Skipping..."
else
    sudo apt update -y
    sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    sudo apt update -y
    sudo apt-get install docker-ce -y 
    sudo usermod -aG docker ${USER}
    su - ${USER}
    printf "\n\nDocker has been set up!\n\n"
fi
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo git clone https://github.com/thinkfiveable/cram-support-bot.git csb
sudo mkdir mm
printf "\n\nMoving ENV files!\n\n"
sudo mv /bots/csb.env /bots/csb/.env
sudo mv /bots/mm.env /bots/mm/.env
printf "\n\nStarting up bots...\n\n"
cd csb
docker-compose up -d --build
printf "\n\nStarted up CSB\n\n"
cd ../mm
docker pull kyb3rr/modmail
docker run -d --restart=unless-stopped --env-file .env kyb3rr/modmail
printf "\n\nStarted up MM"