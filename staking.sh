#/bin/bash

cd ~
  
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get install -y nano htop git
sudo apt-get install -y software-properties-common
sudo apt-get install -y build-essential libtool autotools-dev pkg-config libssl-dev
sudo apt-get install -y libboost-all-dev
sudo apt-get install -y libevent-dev
sudo apt-get install -y libminiupnpc-dev
sudo apt-get install -y autoconf
sudo apt-get install -y automake unzip
sudo add-apt-repository  -y  ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get install -y libdb4.8-dev libdb4.8++-dev
sudo apt-get install libzmq3-dev

cd /var
sudo touch swap.img
sudo chmod 600 swap.img
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
sudo free
sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab
cd

wget https://github.com/panamcoin/Panam/releases/download/1.0.0/panam-1.0.0-x86_64-linux-gnu.tar.gz
tar -xzf panam-1.0.0-x86_64-linux-gnu.tar.gz
rm -rf panam-1.0.0-x86_64-linux-gnu.tar.gz

sudo apt-get install -y ufw
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp
sudo ufw logging on
echo "y" | sudo ufw enable
sudo ufw status
sudo ufw allow 45788/tcp
  
cd
mkdir -p .panam
echo "staking=1" >> panam.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> panam.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> panam.conf
echo "rpcallowip=127.0.0.1" >> panam.conf
echo "listen=1" >> panam.conf
echo "server=1" >> panam.conf
echo "daemon=1" >> panam.conf
echo "logtimestamps=1" >> panam.conf
echo "maxconnections=256" >> panam.conf
echo "addnode=144.202.7.89" >> panam.conf
echo "addnode=149.28.49.245" >> panam.conf
echo "addnode=45.76.22.27" >> panam.conf
echo "addnode=107.191.49.158" >> panam.conf
echo "port=45788" >> panam.conf
mv panam.conf .panam

  
cd
./panamd -daemon
sleep 30
./panam-cli getinfo
sleep 5
./panam-cli getnewaddress
echo "Use the address above to send your PANAM coins to this server"

