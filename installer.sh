#!/bin/bash
VERSION="0.1.4"
LINE="------------"

echo -e "                 
______     _____           _____           _           
| ___ \   /  __ \         |_   _|         | |          
| |_/ /___| /  \/ ___  _ __ | | ___   ___ | | ___ _ __ 
|    // _ \ |    / _ \| '_ \| |/ _ \ / _ \| |/ _ \ '__|
| |\ \  __/ \__/\ (_) | | | | | (_) | (_) | |  __/ |   
\_| \_\___|\____/\___/|_| |_\_/\___/ \___/|_|\___|_|    
                                                  
                                         version: $VERSION -by wqer "
echo $LINE
echo "Installing everything - This might take a while"
echo $LINE
echo "Updating your OS"

sudo apt-get update && sudo apt-get upgrade
sudo apt-get install -y python3-pip
sudo apt-get install -y wget
sudo apt-get install -y git

echo "DONE"
echo $LINE

cd "$HOME" || return 
mkdir tools

echo " --- Installing python3 tools ---"

echo "Installing SQLmap"
cd tools || return
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev
cd sqlmap-dev
sudo printf "%s\n" "alias sqlmap="python3 "$HOME"/tools/sqlmap-dev/sqlmap.py"" >> ~/.bashrc
cd "$HOME" || return 

echo "Installing XSSer"
sudo pip3 install pycurl bs4 pygeoip gobject cairocffi selenium
cd tools || return 
git clone https://github.com/epsylon/xsser
cd xsser || return
sudo python3 setup.py
cd "$HOME" || return 

echo "Installing wfuzz" 
sudo pip3 install wfuzz

echo "Installing knockpy - Additional setup needed later"
sudo apt-get install -y python-dnspython
cd tools || return 
git clone https://github.com/guelfoweb/knock.git
cd knock || return 
echo " SET YOUR OWN VIRUSTOTAL KEY WITH THE COMMAND: nano knockpy/config.json"
sudo python setup.py install
cd "$HOME" || return 

echo "Installing Sublist3r - Additional setup needed later"
cd tools || return 
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r* || return 
sudo pip3 install -r requirements.txt
cd "$HOME" || return 
echo " SET YOUR OWN API KEYS IN THE CONFIG FILE"

echo "Installing XSStrike"
cd tools || return 
git clone https://github.com/s0md3v/XSStrike
cd XSStrike || return 
sudo pip3 install requirements.txt
cd "$HOME" || return

echo "DONE"
echo $LINE

echo "--- Installing go ---"

mkdir golang 
cd "$HOME"/golang || return 
git clone https://github.com/udhos/update-golang
cd "$HOME"/golang/update-golang || return
sudo bash update-golang 
sudo cp /usr/local/go/bin/go /usr/bin/ 
cd "$HOME" || return 
echo "DONE"
echo $LINE

echo "--- Installing go tools ---"

echo "installing gobuster"
go get -u -v github.com/OJ/gobuster
sudo cp go/bin/gobuster /usr/bin

echo " installing amass"
GO111MODULE=on go get -v github.com/OWASP/Amass/v3/...
sudo cp go/bin/amass /usr/bin

echo "installing waybackurls"
go get github.com/tomnomnom/waybackurls
sudo cp go/bin/waybackurls /usr/bin

echo "DONE"
echo $LINE
echo "--- Installing tools ---"

echo "Installing nmap"
sudo apt-get install -y nmap

echo "DONE"
echo $LINE 

echo "--- Installing wordlists ---"

mkdir /usr/share/wordlists
git clone --depth 1 https://github.com/danielmiessler/SecLists.git
sudo cp SecLists /usr/share/wordlists

echo "ALL DONE"
