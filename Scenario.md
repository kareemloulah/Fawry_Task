# Server not reachable 
## first thing i would do see if the serve is pingable from my machine
ping ("server Name/IP")
ex 
```
ping google.com
# To get the ip address for google.com 
nslookup google.com

```
run on the server to get the ip Address 
```
ifconfig
```

### Option 1 Pingable with ip but not the name
we have to check the DNS Settings that checks the name 
```
cat /etc/resolv.conf
```
there should be the following in the output
```
nameserver "router IP"
nameserver 8.8.8.8
```

### Option 2 Not Pingable
since we know that the server is running 
i would check that the server is listening on the ports on this example port 80 and 443
```
netstat -an | grep 80 
lsof -i :80
```
![like with the jenkins server on port 8080](/jenkinstest.png)
if not listening check server config file 
for example jenkins server jenkins should be running on port 8080 as default 
ex :
``` 
cat /etc/default/jenkins
```
see weather the port is configured or not if configured 
check firewall 
``` 
firewall-cmd --list-all 
```
![here port 8080 is passed by the firewall](/Firewallj.png)
port 80 and 443 should be added in the firewall rules 
if not 

```
firewall-cmd --permanent --add-port={80/tcp,443/tcp}
```
the reload firewall service 

```
firewall-cmd --reload 
```
