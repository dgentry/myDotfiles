 systemctl status bluetooth.service
  485  systemctl stop bluetooth.service
  486  systemctl disable bluetooth.service
  487  systemctl stop modemmanager.service
  488  systemctl stop ModemManager.service
  489  systemctl disable ModemManager.service
  490  systemctl list-unit-files --type=service
  491  systemctl disable rpi-display-backlight.service
  492  systemctl list-unit-files --type=service
  493  systemctl list-unit-files --type=service | grep enabled
  494  ls
  495  e rpi_install.sh
  496  es
  497  journalctl _PID=1
  498  systemd-analyze blame
  499  sudo systemctl mask bluetooth.service
