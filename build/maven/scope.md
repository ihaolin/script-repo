# Maven Scope

```bash
# maven提供6个依赖包的作用域<scope></scope>
-------------------
compile:(默认)
build, test, run的时候需要，如:<dependency>	<groupId>log4j</groupId> 
	<artifactId>log4j</artifactId> 
	<version>1.2.14</version>	<!-- may be omitted --> 
	<scope>compile</scope></dependency>
-------------------
provided:
build, test时候需要, 如一些容器包:

-------------------
runtime:
build时不需要，但必须在test,run时的类路径里.
比如那种我们只在反射创建对象的类，并且不会引用

-------------------

test:
compile, run test units时需要，并且不会传递依赖到其他模块
-------------------
system:
类似provided，但其不会从仓库中寻找依赖，而是从本地文件系统。

类似provided，但其不会从仓库中寻找依赖，而是从本地文件系统:

<dependency> 
     <groupId>com.sun</groupId> 
     <artifactId>tools</artifactId>      
     <version>1.6.0</version> 
     <scope>system</scope> 
     <systemPath>
                   ${java.home}/../lib/tools.jar
     </systemPath>
</dependency>

import:
只在标签<dependencyManagement>中使用

－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
dependencyManagement标签:
<dependencyManagement>      <dependencies>            <dependency>				<groupId>com.google.gwt</groupId> 
				<artifactId>gwt-servlet</artifactId> 
				<version>2.5.0</version> 
				<scope>provided</scope>              <exclusions>                    <exclusion>                         <groupId>org.json</groupId>                         <artifactId>json</artifactId>                    </exclusion>               </exclusions>             </dependency>        </dependencies>
</dependencyManagement>
```