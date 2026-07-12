SERVICE="wg-quick-wg0"
if systemctl is-active --quiet "$SERVICE"; then
    systemctl stop "$SERVICE"
else
    systemctl start "$SERVICE"
fi
