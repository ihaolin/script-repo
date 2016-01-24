# LNMP Install
+ nginx
+ mysql
+ php
	+ 安装php
	
	```bash
	yum install php php-fpm 
	```
	
	+ 安装php的MySQL支持
	
	```bash
	yum install php-mysql php-gd libjpeg* php-imap php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-mcrypt php-bcmath php-mhash libmcrypt
	```
	
	+ 自启动php-fpm
	
	```bash
	chkconfig php-fpm on
	/etc/init.d/php-fpm start
	```
+ nginx的php基本配置

	```bash
server {
    listen 80;
    server_name pab.bingex.com;

    access_log  logs/pab-access.log;
    error_log   logs/pab-error.log;

    # root /var/www/phabricator;

    location ~\.php$ {
        root /var/www/phabricator;
        # passenger_enbaled on;
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME  $document_root/$fastcgi_script_name;
        include fastcgi_params;
    }
}
	```	
+ php基本配置/etc/php.ini

	```bash
	date.timezone = PRC
	expose_php = Off
	magic_quotes_gpc = On
	short_open_tag = ON
	open_basedir = .:/tmp/ 
	```
	
+ 配置php-fpm启动用户/etc/php-fpm.d/www.conf

	```bash
	# 该用户应该同nginx启动用户一致，如www运行的nginx
	[git@iss-test mnt]$ ps -ef | grep nginx
	root      2729     1  0 Mar03 ?        00:00:00 nginx: master process ./sbin/nginx
	www       6635  2729  0 16:34 ?        00:00:00 nginx: worker process
	www       6636  2729  0 16:34 ?        00:00:00 nginx: cache manager process
	git       7255  1370  0 16:48 pts/0    00:00:00 grep nginx
	```