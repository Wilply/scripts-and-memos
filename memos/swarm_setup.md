## Docker Swarm setup

#### Config
Allow root SSH ('permit yes' and remove '#')
```bash
rc-service sshd reload
```

#### Package
```bash
apk update
apk add cifs-utils git
```
#### CIFS
cred.credentials
```bash
username=XXX
password=XXX
```
Add next line to /etc/fstab
```bash
//host.fqdn/USERS/swarm /mnt/cifs/swarm cifs credentials=/path/to/cred.credentials,uid=0,gid=0 0 0
```
Create Dir
```bash
mkdir -p /mnt/cifs/swarm
```
Mount
```bash
mount -a
```
