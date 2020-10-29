## Docker Swarm setup

#### Config
Allow root SSH
```bash
sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
rc-service sshd reload
```

#### Package
Enable community repositorie
```bash
sed -i '3s/#//' /etc/apk/repositories
```
Install package
```bash
apk update && \
apk add --no-cache \
    git \
    docker
```
CIFS :
```bash
apk add --no-cache cifs-utils
```
NFS :
```bash
apk add --no-cache nfs-utils
```
Guest-agent (Proxmox) :
```bash
apk add --no-cache qemu-guest-agent
```

#### Set TimeZone (if not set at installation)
```bash
apk add --no-cache tzdata
cp /usr/share/zoneinfo/Europe/Paris /etc/localtime && \
echo "Europe/Paris" >  /etc/timezone
apk del tzdata
```

#### Guest-agent
Enable Qemu-agent in proxmox (options => QEMU Guest Agent => Enable) and **reboot from proxmox** \
Edit init.d file ([bug report](https://gitlab.alpinelinux.org/alpine/aports/-/issues/8894 "Alpine Linux GitLab"))
```bash
sed -i 's/^command_args.*/command_args="-m virtio-serial -p \/dev\/vport2p1 -l \/var\/log\/qemu-ga.log -d"/g' /etc/init.d/qemu-guest-agent
```
Start and enable at boot
```bash
rc-service qemu-guest-agent start
rc-update add qemu-guest-agent default
```

#### NFS
**Before doing installing, make sure the server has access to the share**

Start services
```bash
rc-service nfsmount start
```
Create directory
```bash
mkdir -p /mnt/swarm
```
Add next line to /etc/fstab
```bash
echo "host.fqdn:/path/on/server /local/path nfs _netdev,vers=4 0 0" >> /etc/fstab
```
Mount
```bash
mount -a
```
Mount at boot
```bash
rc-update add nfsmount default
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
echo "//host.fqdn/USERS/swarm /mnt/cifs/swarm cifs credentials=/path/to/cred.credentials,exec,rw,uid=0,gid=0,dir_mode=0777,file_mode=0777 0 0" >> /etc/fstab
```
Mount
```bash
mount -a
```
Mount at boot
```bash
rc-update add netmount default
```
