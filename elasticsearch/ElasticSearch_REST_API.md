# ElasticSearch REST API

## ![](es.png)

+ ElasticSearch REST基础API

	+ [集群相关](#cluster)

	+ [索引](#index)
	
	+ [文档](#doc)
	
	+ [批量操作](#batch)
	
	+ [查询](#search)
	
	+ [映射](#mapping)
	
+ <span id="cluster">集群健康状态检查</span>

	```ruby
	curl 'localhost:9200/_cat/health?v'
	epoch      timestamp cluster       status node.total node.data shards pri relo init unassign pending_tasks
	1431582262 13:44:22  elasticsearch yellow          1         1     10  10    0    0       10             0
	```
	
+ 集群节点检查
	
	```ruby
	curl 'localhost:9200/_cat/nodes?v'
	host       ip            heap.percent ram.percent load node.role master name
	haolin-mbp 192.168.0.139            9          71 1.62 d         *      Daisy Johnson
	```	 
	
+ <span id="index">查看集群index</span>

	```ruby
	curl 'localhost:9200/_cat/indices?v'
	health status index    pri rep docs.count docs.deleted store.size pri.store.size
	yellow open   bank       5   1       1000            0    417.3kb        417.3kb
	yellow open   customer   5   1          2            0      5.3kb          5.3kb
	```	
	
+ 创建index

	```ruby
	curl -XPUT 'localhost:9200/customer?pretty'
	```	
	
+ 删除index

	```ruby
	curl -XDELETE 'localhost:9200/customer?pretty'
	```	
+ <span id="doc">创建文档</span>

	```ruby
	curl -XPUT 'localhost:9200/customer/external/1?pretty' -d '
	{
	  "name": "John Doe"
	}'
	```

+ 查询文档
	
	```ruby
	curl -XGET 'localhost:9200/customer/external/1?pretty'
	{
	  "_index" : "customer",
	  "_type" : "external",
	  "_id" : "1",
	  "_version" : 7,
	  "found" : true,
	  "_source":
		{
		  "name": "John Doe"
		}
	}
	```	

+ 删除文档

	```ruby
	curl -XDELETE 'localhost:9200/customer/external/1?pretty'
	```	ruby
	```ruby
	# 删除name包含John的文档
	curl -XDELETE 'localhost:9200/customer/external/_query?pretty' -d '
	{
	  "query": { "match": { "name": "John" } }
	}'
	```
	
+ 更新文档

	```ruby
	curl -XPOST 'localhost:9200/customer/external/1/_update?pretty' -d '
	{
	  "doc": { "name": "Jane Doe", "age": 20 }
	}'
	```	
	```ruby
	# 使用groovy脚本进行更新(v1.4.3后默认关闭该功能，需配置script.groovy.sandbox.enabled: true)
	curl -XPOST 'localhost:9200/customer/external/1/_update?pretty' -d '
	{
	  "script" : "ctx._source.age += 5"
	}'
	```
		
+ <span id="batch">批量创建文档</span>

```ruby
curl -XPOST 'localhost:9200/customer/external/_bulk?pretty' -d '
{"index":{"_id":"1"}}
{"name": "John Doe" }
{"index":{"_id":"2"}}
{"name": "Jane Doe" }'
```

+ 批量执行操作

```ruby
curl -XPOST 'localhost:9200/customer/external/_bulk?pretty' -d '
{"update":{"_id":"1"}}
{"doc": { "name": "John Doe becomes Jane Doe" } }
{"delete":{"_id":"2"}}'
```

+ 批量导入json文件

```ruby
curl -XPOST 'localhost:9200/bank/account/_bulk?pretty' --data-binary @accounts.json
# 文件格式如:
{"index":{"_id":"1"}}
{"account_number":1,"balance":39225,"firstname":"Amber","lastname":"Duke","age":32,"gender":"M","address":"880 Holmes Lane","employer":"Pyrami","email":"amberduke@pyrami.com","city":"Brogan","state":"IL"}
{"index":{"_id":"6"}}
{"account_number":6,"balance":5686,"firstname":"Hattie","lastname":"Bond","age":36,"gender":"M","address":"671 Bristol Street","employer":"Netagy","email":"hattiebond@netagy.com","city":"Dante","state":"TN"}
...
```

+ <span id="search">搜索API</span>
	
	+ 查询所有bank下的文档
	
		```ruby
		curl 'localhost:9200/bank/_search?q=*&pretty'
		# 等价于
		curl -XPOST 'localhost:9200/bank/_search?pretty' -d '
		{
		  "query": { "match_all": {} }
		}'
		```
	
	+ 多条件查询(按balance降序，且获取前10条数据, 仅获取)
		
		```ruby
		curl -XPOST 'localhost:9200/bank/_search?pretty' -d '
		{
			"query": { "match_all": {} },
			"from": 0,
			"size": 10,
			"sort": { "balance": { "order": "desc" } },
			"_source": ["account_number", "balance"]
		}'
		```
	+ 匹配查询
	
		```ruby
		# account_number=20的account
		curl -XPOST 'localhost:9200/bank/_search?pretty' -d '
		{
		  "query": { "match": { "account_number": 20 } }
		}'
		# address包含mill或lane的account(大小写不敏感)
		curl -XPOST 'localhost:9200/bank/_search?pretty' -d '
		{
		  "query": { "match": { "address": "mill lane" } }
		}'
		# address包含"mill lane"的account
		curl -XPOST 'localhost:9200/bank/_search?pretty' -d '
		{
		  "query": { "match_phrase": { "address": "mill lane" } }
		}'
		```
	+ 布尔查询
		
		```ruby
		# address必须包含mill和lane
		curl -XPOST 'localhost:9200/bank/_search?pretty' -d '
		{
		  "query": {
		    "bool": {
		      "must": [
		        { "match": { "address": "mill" } },
		        { "match": { "address": "lane" } }
		      ]
		    }
		  }
		}'
		# address必须包含mill或lane
		curl -XPOST 'localhost:9200/bank/_search?pretty' -d '
		{
		  "query": {
		    "bool": {
		      "should": [
		        { "match": { "address": "mill" } },
		        { "match": { "address": "lane" } }
		      ]
		    }
		  }
		}'
		# address必须不包含mill或lane
		curl -XPOST 'localhost:9200/bank/_search?pretty' -d '
		{
		  "query": {
		    "bool": {
		      "must_not": [
		        { "match": { "address": "mill" } },
		        { "match": { "address": "lane" } }
		      ]
		    }
		  }
		}'
		# 年龄未40且state不为"ID"
		curl -XPOST 'localhost:9200/bank/_search?pretty' -d '
		{
		  "query": {
		    "bool": {
		      "must": [
		        { "match": { "age": "40" } }
		      ],
		      "must_not": [
		        { "match": { "state": "ID" } }
		      ]
		    }
		  }
		}'
		```
+ 过滤器(Filter)查询

	```ruby
	# 查询余额>=20000且<=30000的账户
	curl -XPOST 'localhost:9200/bank/_search?pretty' -d '
	{
	  "query": {
	    "filtered": {
	      "query": { "match_all": {} },
	      "filter": {
	        "range": {
	          "balance": {
	            "gte": 20000,
	            "lte": 30000
	          }
	        }
	      }
	    }
	  }
	}'
	```	

+ 分组聚合

	```ruby
	# 按照state分组，并且不返回查询数据(size = 0)
	curl -XPOST 'localhost:9200/bank/_search?pretty' -d '
	{
	  "size": 0,
	  "aggs": {
	    "group_by_state": {
	      "terms": {
	        "field": "state"
	      }
	    }
	  }
	}'
	# 按照state分组，并计算每组中balance的平均值
	curl -XPOST 'localhost:9200/bank/_search?pretty' -d '
	{
	  "size": 0,
	  "aggs": {
	    "group_by_state": {
	      "terms": {
	        "field": "state"
	      },
	      "aggs": {
	        "average_balance": {
	          "avg": {
	            "field": "balance"
	          }
	        }
	      }
	    }
	  }
	}'
	# 按state分组，计算每组balance的平均值，并按平均值降序排序
	curl -XPOST 'localhost:9200/bank/_search?pretty' -d '
	{
	  "size": 0,
	  "aggs": {
	    "group_by_state": {
	      "terms": {
	        "field": "state",
	        "order": {
	          "average_balance": "desc"
	        }
	      },
	      "aggs": {
	        "average_balance": {
	          "avg": {
	            "field": "balance"
	          }
	        }
	      }
	    }
	  }
	}'
	# 按age分组，分别为20~30，30~40，40~50，且每组再按gender分组(求出每组的平均balance)
	curl -XPOST 'localhost:9200/bank/_search?pretty' -d '
	{
	  "size": 0,
	  "aggs": {
	    "group_by_age": {
	      "range": {
	        "field": "age",
	        "ranges": [
	          {
	            "from": 20,
	            "to": 30
	          },
	          {
	            "from": 30,
	            "to": 40
	          },
	          {
	            "from": 40,
	            "to": 50
	          }
	        ]
	      },
	      "aggs": {
	        "group_by_gender": {
	          "terms": {
	            "field": "gender"
	          },
	          "aggs": {
	            "average_balance": {
	              "avg": {
	                "field": "balance"
	              }
	            }
	          }
	        }
	      }
	    }
	  }
	}'
	```	

+ <span id="mapping">创建mapping</span>

	```ruby
	curl -XPUT 'http://localhost:9200/twitter/_mapping/tweet' -d '
	{
	    "tweet" : {
	        "properties" : {
	            "message" : {"type" : "string", "store" : true }
	        }
	    }
	}'
	```	
+ 查询mapping

	```bash
	curl -XGET 'http://localhost:9200/twitter/_mapping/tweet'
	```	
	
	