# Maven basic

+ 配置本地仓库settings.xml模板:

	```bash
	<?xml version="1.0" encoding="UTF-8"?>
	<settings>
	      <localRepository>/path/to/local_repo</localRepository>
	      <profiles>
	        <profile>
	          <id>nexus-releases</id>
	          <repositories>
	            <repository>
	            <id>cloud-repository</id>
	            <name>cloud private repository</name>
	            <url>http://www.xxxx.com/nexus/content/groups/public</url>
	            <releases>
	              <enabled>true</enabled>
	            </releases>
	            <snapshots>
	              <enabled>false</enabled>
	            </snapshots>
	          </repository>
	        </repositories>
	        <pluginRepositories>
	            <pluginRepository>
	            <id>cloud-plugin-repository</id>
	            <name>cloud plugin repository</name>
	            <url>http://www.xxx.com/nexus/content/groups/public</url>
	            <releases>
	              <enabled>true</enabled>
	            </releases>
	            <snapshots>
	               <enabled>false</enabled>
	            </snapshots>
	          </pluginRepository>
	        </pluginRepositories>
	      </profile>
	      <profile>
	        <id>nexus-snapshots</id>
	        <repositories>
	          <repository>
	            <id>cloud-snapshots</id>
	            <name>cloud private snapshots</name>
	            <url>http://www.xxx.com/nexus/content/repositories/snapshots/</url>
	          </repository>
	        </repositories>
	        <pluginRepositories>
	          <pluginRepository>
	            <id>cloud-snapshots</id>
	            <name>cloud private plugin repository</name>
	            <url>http://www.xxx.com/nexus/content/repositories/snapshots/</url>
	          </pluginRepository>
	        </pluginRepositories>
	      </profile>
	    </profiles>
	    <activeProfiles>
	      <activeProfile>nexus-releases</activeProfile>
	      <activeProfile>nexus-snapshots</activeProfile>
	    </activeProfiles>
	    <servers>
	      <server>
	        <id>nexus-releases</id>
	        <username>username</username>
	        <password>password</password>
	      </server>
	      <server>
	        <id>nexus-snapshots</id>
	        <username>username</username>
	        <password>password</password>
	      </server>
	    </servers>
	</settings>
	```
	
+ maven包短定义:

	```bash
	<groupId>:<artifactId>:<type>:<version>:<scope>
	```

+ maven依赖分析:

	```bash
	mvn dependency:tree
	```

+ mave相同包不同版本选择原则:
	
	+ **就近原则**:
		+ 即低级别(直接)依赖的优先级大于高级别(间接)依赖。
	+ **最先发现**:
		+ 如同一级别出现不同版本的包依赖，则选择第一个出现的依赖包。

+ maven包排除:

	```xml
<dependency>
        <groupId>commons-collections</groupId>
        <artifactId>commons-collections</artifactId>
        <version>${commons-collections.version}</version>
        <exclusions>
            <!-- execlue junit -->
            <exclusion>
                <artifactId>junit</artifactId>
                <groupId>junit</groupId>
            </exclusion>
        </exclusions>
</dependency>	
	```

+ maven安装源码:

	```bash
	mvn clean source:jar install -Dmaven.test.skip=true
	```

+ maven安装jar文件到本地:

	```bash
	mvn install:install-file -Dfile=abc.jar -DgroupId=com.mycompany.myproduct 
-DartifactId=abc -Dversion=1.0 -Dpackaging=jar -DgeneratePom=true 	
	```

+ maven部署jar包到仓库:

	```bash
	mvn deploy:deploy-file -Dfile=/path/to/jar -DgroupId=<groupId> -DartifactId=<DartifactId> -Dversion=<version> -Dpackaging=jar -Durl=http://xxx.com/nexus/content/repositories/snapshots -DrepositoryId=<repositoryId>
	```

+ 运行时定义本地仓库:

	```bash
	mvn clean -Dm2.localRepository=${REPO_PATH} ...
	```

+ 属性定义与引用

	```xml
	<properties>
	    <junit.version>4.9</junit.version>
	    <hibernate.version>3.3.1.GA</hibernate.version>
	    <richfaces.version>4.1.0.Final</richfaces.version>
	</properties>
	${junit.version}
	```

+ 排除某些模块:

	```bash
	mvn -pl '!module-name1,!module-name2' install
	```