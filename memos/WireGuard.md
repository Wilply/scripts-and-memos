
## Wireguard Install

#### 1) Enable community repo
```bash 
echo "http://dl-cdn.alpinelinux.org/alpine/v3.12/community" >> /etc/apk/repositories
```
#### 2) Install
```bash
apk update
apk add wireguard-tools iptables
```
#### 3) Enable Routing
```bash
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.proxy_arp = 1" >> /etc/sysctl.conf
echo wireguard >> /etc/modules
```
#### 4) Generate Keys
```bash
cd /etc/wireguard && wg genkey | tee privatekey | wg pubkey > publickey
```
#### 5) Configure Interface
[wg0.conf]
```bash
[Interface]
PrivateKey = <Server Private Key>
ListenPort = <Port>
Address = X.Y.Z.1/24 #Peer network =/= lan
#NAT :
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o <iface> -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o <iface> -j MASQUERADE
```
#### 6) Configure Peer
[wg0.conf]
```bash
[Peer]
PublicKey = <Client Public Key>
AllowedIPs = X.Y.Z.2/32
```
#### 7) Configure Client
```bash
[Interface]
PrivateKey = <Client Private Key>
ListenPort = <Port>
Address = X.Y.Z.2/32
DNS = A.B.C.D

[Peer]
PublicKey = <Server Public Key>
AllowedIPs = X.Y.Z.0/24, #any other networks to route to vpn (eg : 0.0.0.0/0 or lan 192.168.0.0/16)
Endpoint = <Server Public @IP>:<Port>
```
