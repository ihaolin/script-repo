# IP Tables Configuration

* list all rules and line-number:

```bash
	iptables -nL --line-number
```
* add an input rule to open a port:

```bash
	iptables -A INPUT -p tcp --dport 3306 -j ACCEPT
```
* remove an rule:

```bash
iptables -D INPUT <line_number>
```
* update a rule(update rule to ACCEPT:

```bash
iptables -R INPUT <liner_number> -j ACCEPT
```
* save iptables 

```bash
/etc/init.d/iptables save
```