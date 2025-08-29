SOURCE=${BASH_SOURCE[0]}
source check-interactive.sh
sudo mount -t cifs //TIMUR-PC/share /mnt/share     -o username=karim,password=1,vers=3.0
yazi /mnt/share
