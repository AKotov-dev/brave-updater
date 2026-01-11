# brave-updater

A simple updater for the Brave Browser on RPM- and DEB-based Linux systems.

## Description

`brave-updater` is a small helper package that automatically updates
the Brave Browser using `dnf` or `apt`.

The browser update is performed **once per day**, **5 minutes after system startup**.

**Important**  
- `brave-updater` does **not** install Brave automatically  
- The updater runs **only if the browser is already installed**  
- To install the Brave browser, use the information on the [developers' website](https://brave.com/linux/)

## Components

- Update script:  
  [/etc/brave-updater/brave-updater.sh](https://github.com/AKotov-dev/brave-updater/blob/main/etc/brave-updater/brave-updater.sh)

- systemd service:  
  [brave-updater.service](https://github.com/AKotov-dev/brave-updater/blob/main/etc/systemd/system/brave-updater.service)

- State file (is being created in the work):  
  `/etc/brave-updater/date_stamp`

```
# Example status check
systemctl status brave-updater.service

# Logs can be viewed with:
journalctl -u brave-updater.service
```

**Notes**
+ The updater will not run more than once per day
+ All operations are performed as root via systemd
+ The updater will not run in live environments (Mageia/MgaRemix)
