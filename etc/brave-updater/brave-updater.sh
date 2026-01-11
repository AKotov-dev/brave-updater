#!/bin/bash

# Brave browser update script (RPM + DEB)
#
# --Initial installation of Brave in Mageia (dnf-4)--
# sudo dnf install dnf-plugins-core
# sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
# sudo dnf install brave-browser
#
# --Initial installation of Brave in Debian/Ubuntu--
# sudo apt install curl
# sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
# sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources
# sudo apt update
# sudo apt install brave-browser
#
# Release Channel Installation: https://brave.com/linux/

# Не запускать с флешки (Mageia/MgaRemix)
[ -d /run/mgalive/ovlsize ] && exit 0

TODAY="$(date '+%d-%m-%Y')"
STAMP="/etc/brave-updater/date_stamp"

# Сегодня уже обновлялся?
[ "$(cat "$STAMP" 2>/dev/null)" = "$TODAY" ] && exit 0

# Проверяем, есть ли браузер
[ -f /opt/brave.com/brave/brave-browser ] || exit 0

# Задержка после загрузки системы
echo "5 min delay..."
sleep 300

# Сеть есть?
echo "Checking the connection..."
if ping -c 3 google.com > /dev/null 2>&1; then
    echo "[ OK ]"
else
    echo "[ ERROR ]"
    echo "$TODAY Internet connection: ERROR" > "$STAMP"
    exit 1
fi

# Определяем пакетный менеджер
if command -v dnf >/dev/null 2>&1; then
    PM="dnf"
elif command -v apt-get >/dev/null 2>&1; then
    PM="apt"
else
    echo "Unsupported package manager"
    exit 1
fi

case "$PM" in
    dnf)
        # Обновляем Brave
        dnf -y --refresh upgrade brave-browser --disablerepo="*" --enablerepo="brave-browser"
        ;;
    apt)
        # Обновляем Brave
        apt-get update
        apt-get install -y --only-upgrade brave-browser
        ;;
esac

# Поставить штамп времени
echo "$TODAY" > "$STAMP"

exit 0
