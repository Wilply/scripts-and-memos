## AdGuard Home Install 

#### 1) Download executable
```bash 
wget -O /adguard_home.tar.gz https://static.adguard.com/adguardhome/release/AdGuardHome_linux_amd64.tar.gz
```
#### 2) Extract
```bash
tar -xzvf /adguard_home.tar.gz -C /
```
#### 3) Clean
```bash
rm -rf /adguard_home.tar.gz
```
#### 4) Install
```bash
wget -O /etc/init.d/AdGuardHome https://raw.githubusercontent.com/Wilply/scripts-and-memos/master/scripts/AdGuardHome
```
#### 5) Run 
```bash
openrc -s AdGuardHome start
openrc -s AdGuardHome status
```
#### 6) [Optional] Run AdGuardHome at boot
```bash
rc-update add AdGuardHome
```
