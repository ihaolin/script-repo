#Logstash

+ 下载[zip](https://download.elastic.co/logstash/logstash/logstash-1.5.4.zip)包，解压到本地。


基本使用
---

+ 启动:
  
  ```bash
  ${LOGSTASH_HOME}/bin/logstash -f <config_file>
  ```
  或先测试配置文件
  
  ```bash
  ${LOGSTASH_HOME}/bin/logstash --configtest -f <config_file>
  ```

+ 最简配置:

	```bash
	input {
	    stdin {} #标准输入，即键盘输入
	}
	
	output {
	    stdout {} #标准输出，即终端输出
	}
	```
+ nginx日志配置模板:

	+ 若nginx日志格式:
	
	```ruby
	log_format  main  '$remote_addr "$request" '
                      '$status $body_bytes_sent '
                      '"$http_user_agent"';
	```
	
	+ 对应logstash配置文件:
	
	```ruby
	input {
	    file {
	         path => "/usr/local/var/log/nginx/access.log" # 文件路径
	         start_position => beginning # 读取位置
	    }
	}
	
	filter {
	    mutate {
	        replace => {
	             type => "nginx_access" # 将默认类型logs替换为nginx_access
	        }
	    }
	    grok {
	        match => {
	             message => "%{IPORHOST:client_ip} \"(?:%{WORD:verb} %{NOTSPACE:request}(?: HTTP/%{NUMBER:http_version})?|-)\" %{NUMBER:response} (?:%{NUMBER:bytes}|-) %{QS:agent}"
	        }
	    }
	}
	output {
		 # 输出到elasticsearch
	    elasticsearch {
	         host => localhost
	         protocol => "http"
	    }
	}
	```
		