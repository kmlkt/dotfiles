RED='\e[31m'
GREEN='\e[32m'
BLUE='\e[34m'
NC='\e[0m'

PKG_FILE=~/.config/packages.txt
INSTALL=$(comm -13 <(yay -Qqe | sort) <(sort $PKG_FILE))
REMOVE=$(comm -23 <(yay -Qqe | sort) <(sort $PKG_FILE))

if [[ -z "$INSTALL" && -z "$REMOVE" ]]; then
echo "Nothing to do"
exit
fi

echo "To install:"
echo -e $GREEN
echo $INSTALL
echo -e $NC

echo "To remove:"
echo -e $RED
echo $REMOVE
echo -e $NC

read -p "Proceed? (Y/n)" yn
case $yn in
    [Nn]* ) exit;;
esac
echo "Okay, let's do it"
yay
yay --sudoloop -S --noconfirm $INSTALL
yay --sudoloop -Rns --noconfirm $REMOVE
echo "We did it"
