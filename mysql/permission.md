# MySql权限

+ 添加用户:

	```bash
	grant all privileges on *.* to username@'%' identified by 'password' [with grant option];
	```
	
	
+ 修改用户密码:

	```
	UPDATE user SET password=PASSWORD("password") WHERE user='username';
	```