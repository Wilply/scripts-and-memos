
```
[Interface]
PrivateKey = <Server Private Key>
ListenPort = 58330
Address = 10.3.3.1/24
#change ens18 with server lan interface
PostUp = /usr/sbin/iptables -A FORWARD -i %i -j ACCEPT; /usr/sbin/iptables -A FORWARD -o %i -j ACCEPT; /usr/sbin/iptables -t nat -A POSTROUTING -o ens18 -j MASQUERADE
PostDown = /usr/sbin/iptables -D FORWARD -i %i -j ACCEPT; /usr/sbin/iptables -D FORWARD -o %i -j ACCEPT; /usr/sbin/iptables -t nat -D POSTROUTING -o ens18 -j MASQUERADE

[Peer]
PublicKey = <Client Public Key>
AllowedIPs = 10.3.3.0/24 #Test w/ ...1/32
```
