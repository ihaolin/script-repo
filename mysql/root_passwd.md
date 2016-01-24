# 几种修改root密码的方法

+ 登录到mysql进行更改:
	
	```bash
	mysql -u root
	mysql> SET PASSWORD FOR 'root'@'localhost' = PASSWORD('newpass');
	```
+ 使用mysqladmin修改
	+ 若root没有密码:
		
		```bash
		mysqladmin -u root password "newpass"
		```	
	+ 若root已有密码:

		```bash
		mysqladmin -u root password oldpass "newpass"
		```	
+ 更新mysql用户表:

	```bash
	mysql -u root
	mysql> use mysql;
	mysql> UPDATE user SET Password = PASSWORD('newpass') WHERE user = 'root';
	mysql> FLUSH PRIVILEGES;
	```
+ 若丢失root密码，可用mysql_safe启动mysql，再更新user表:
	
	```bash
	mysqld_safe --skip-grant-tables&
	mysql -u root mysql
	mysql> UPDATE user SET password=PASSWORD("new password") WHERE user='root';
	mysql> FLUSH PRIVILEGES;
	```	