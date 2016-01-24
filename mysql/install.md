# Install MySQL on Centos 6.x

* add yum repo

```bash
sudo vim /etc/yum.repos.d/MariaDB.repo
```
```bash
# MariaDB 5.5 CentOS repository list - created 2014-01-27 06:39 UTC
# http://mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/5.5/centos6-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
```
* install MariaDB:

```bash
sudo yum -y install MariaDB-server MariaDB-client
```
* config mysql.server: sudo vim /etc/my.cnf.d/server.cnf:

```bash
[server]
pid-file               = /var/run/mysqld/mysqld.pid
bind-address           = 0.0.0.0
character-set-server   = utf8
collation-server       = utf8_unicode_ci
init_connect           = 'SET NAMES utf8'
```
* make some prepare

```bash
sudo mkdir -p /var/run/mysqld
sudo chown mysql:mysql /var/run/mysqld
sudo　service mysql start
sudo mysql_secure_installation
```
* some privilege settings:

```bash
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```
* last

```bash
NOTE: filter your firewall.
```