# Jenkins API

```bash
1.创建

curl -X POST http://www.xxx.xxx/jenkins/createItem?name=JavaStd  --user peterguo:peterguo --data-binary "@javastd.config.xml" -H "Content-Type: text/xml"

2.禁用 

curl -X POST http://www.xxx.xxx/jenkins/job/JavaStd/disable  --user peterguo:peterguo

3.启用 

curl -X POST http://www.xxx.xxx/jenkins/job/JavaStd/enable --user peterguo:peterguo

4.删除 

curl -X POST http://www.xxx.xxx/jenkins/job/JavaStd/doDelete --user peterguo:peterguo

5.获取项目描述 

curl -X GET http://www.xxx.xxx/jenkins/job/JavaStd/description --user peterguo:peterguo

6.获取配置文件 

curl -X GET http://www.xxx.xxx/jenkins/job/JavaStd/config.xml --user peterguo:peterguo

7.触发SCM检查 

curl -X GET http://www.xxx.xxx/jenkins/job/JavaStd/polling --user peterguo:peterguo

8.普通触发 

curl -X GET http://www.xxx.xxx/jenkins/job/JavaStd/build --user peterguo:peterguo

9.带参数触发

curl -X GET "http://www.xxx.xxx/jenkins/job/helloworld-freestyle/buildWithParameters?bAllTest=&Choices=2&strParam=abc" --user peterguo:peterguo

10.带参数和补丁触发  

curl -X POST "http://www.xxx.xxx/jenkins/job/helloworld-freestyle/buildWithParameters?bAllTest=&Choices=2&strParam=abc" --user peterguo:peterguo -F "action=upload" -F "patch.diff=@OtherTest.java.patch"

注：带补丁触发需要先安装补丁插件，并设置项目的补丁参数
```