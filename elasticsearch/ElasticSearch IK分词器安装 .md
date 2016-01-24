# ElasticSearch IK分词器安装 

+ How to install

	```bash
	git clone https://github.com/medcl/elasticsearch-analysis-ik
	cd elasticsearch-analysis-ik
	mvn clean package
	${ES_HOME}/bin/plugin --install analysis-ik --url file:/path/to/elasticsearch-analysis-ik-${version}.zip
	```
+ 配置`elasticsearch.yml `

	```bash
	index.analysis.analyzer.ik.type : “ik”
	```	
	
+ 字典配置

	```bash
	cp -r ${elasticsearch-analysis-ik}/config/ik ${ES_HOME}/config
	```