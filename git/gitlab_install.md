# GitLab 7.4.5安装

For Centos 6.5
---

+ 找一台比较相对干净的Centos服务器;
+ 参考文档:
	+ [https://github.com/gitlabhq/gitlab-recipes/tree/master/install/centos](https://github.com/gitlabhq/gitlab-recipes/tree/master/install/centos)
+ 注意事项:
	+ 对于SSL支持，可使用[沃通](https://www.wosign.com/)提供的免费证书;
	+ gitlab7.4.5与参考文档中gitlab-shell2.1.0是不兼容的，导致ssh连接失败，安装时使用gitlab-shell2.0.1即可:
		
		```bash
		sudo -u git -H bundle exec rake gitlab:shell:install[v2.1.0] REDIS_URL=unix:/var/run/redis/redis.sock RAILS_ENV=production
		```
	
	+ email配置
	    
	    ```bash
	    # 1. vim config/environments/production.rb :
	    
	        config.action_mailer.delivery_method = :smtp
	    # 2. vim cp config/initializers/smtp_settings.rb.sample config/initializers/smtp_settings.rb :
	    
	        # self postfix:
	            address: "mail.hao0.me",
                port: 25,
                user_name: "git",
                password: "",
                domain: "hao0.me",
                authentication: :login,
                enable_starttls_auto: true
	        
	        # 163: 
                address: "smtp.163.com",
                port: 25,
                user_name: "xxx",
                password: "yyy",
                domain: "163.com",
                authentication: :plain,
                enable_starttls_auto: true
                
	        # 腾讯企业邮箱:
	            address: "smtp.exmail.qq.com",
                port: 25,
                user_name: "xxx@yyy.com",
                password: "zzzz",
                domain: "smtp.qq.com",
                authentication: :plain,
                enable_starttls_auto: true,
	            
	    ```

	