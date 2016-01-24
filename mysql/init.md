# init mysql

* set root password:

```bash
SET PASSWORD = PASSWORD('root');
```
* enable remote access

```bash
GRANT ALL PRIVILEGES ON *.* TO 'root’@‘192.168.141.%’ IDENTIFIED BY 'root' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```