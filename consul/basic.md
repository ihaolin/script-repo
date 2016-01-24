# Consul 基本使用

+ server模式启动agent:

	```bash
	consul agent -server -bootstrap-expect 1 -data-dir /tmp/consul
	```
+ 查看consul集群状态:
   
   ```bash
   consul members [-detailed]
   ```	

+ 通过```HTTP API```查看集群状态:

	```bash
	curl localhost:8500/v1/catalog/nodes?pretty
	```
	
+ 通过```DNS interface```查看集群节点

	```bash
	dig @127.0.0.1 -p 8600 <node_name>.node.consul
	```

+ 启动服务(在启动consul时指定配置文件目录```-config-dir```:

	```bash
	# 在配置目录中配置服务，如:
	{
	    "service": {
	        "name": "nginx",
	        "tags": ["web server"],
	        "port": 80
	    }
	}
	# 启动consul
	consul agent -server -bootstrap-expect 1 -data-dir /tmp/consul -config-dir /etc/consul.d
	```		
	
+ 查询服务:

	```bash
	# DNS API
	dig @127.0.0.1 -p 8600 [tag.]<service_name>.service.consul [SRV]
	# HTTP API
	curl http://localhost:8500/v1/catalog/service/nginx?pretty
	```
+ 查询节点

	```bash
	dig @127.0.0.1 -p 8600 <node_name>.node.consul
	```

+ 启动集群

	```bash
	# 绑定节点IP，启动agent
	consul agent -server -bootstrap-expect 1 -data-dir /tmp/consul -node=agent1-bind=192.168.0.101
	consul agent -data-dir /tmp/consul -node=agent2-bind=192.168.0.102
	# agent1加入到agent2
	consul join 192.168.0.102
	``` 
+ 检查集群状态

	```bash
	curl http://localhost:8500/v1/health/state/critical?pretty
	```	
+ K/V存储:

	```bash
	curl -X PUT -d 'test' http://localhost:8500/v1/kv/web/key1
	curl -X PUT -d 'test' http://localhost:8500/v1/kv/web/key2?flags=42
	curl -X PUT -d 'test'  http://localhost:8500/v1/kv/web/sub/key3
	# 获取所有K/V
	curl http://localhost:8500/v1/kv/?recurse
	# 获取键web/key1
	curl http://localhost:8500/v1/kv/web/key1
	# 删除键web/sub
	curl -X DELETE http://localhost:8500/v1/kv/web/sub?recurse
	```	

+ WEB UI:

	```bash
	consul agent -ui-dir /path/to/ui
	```	