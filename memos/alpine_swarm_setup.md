## Docker Swarm setup

#### Config
Allow root SSH ('permit yes' and remove '#')
```bash
rc-service sshd reload
```

#### Package
```bash
apk update
apk add git \
    tzdata \
    cifs-utils \
    nfs-utils
```

#### Set TimeZone
```
cp /usr/share/zoneinfo/Europe/Paris /etc/localtime && \
echo "Europe/Paris" >  /etc/timezone
```

#### NFS
**Before doing installing, make sure the server has access to the share**

Create directory
```bash
mkdir -p /mnt/swarm
```
Add next line to /etc/fstab
```bash
host.fqdn:/volume1/SWARM /mnt/swarm nfs _netdev,vers=4 0 0
```
Mount & start services
```bash
rc-service nfsmount start
```
Mount at boot
```bash
rc-update add nfsmount default
rc-update add netmount default
```
#### CIFS
cred.credentials
```bash
username=XXX
password=XXX
```
Create directory
```bash
mkdir -p /mnt/cifs/swarm
```
Add next line to /etc/fstab
```bash
//host.fqdn/USERS/swarm /mnt/cifs/swarm cifs credentials=/path/to/cred.credentials,exec,rw,uid=0,gid=0,dir_mode=0777,file_mode=0777 0 0
```
Mount
```bash
mount -a
```
Mount at boot
```bash
rc-update add netmount default
```
