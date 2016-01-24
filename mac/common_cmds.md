# Commands on Mac

* 开关掉spotlight index, 尼玛太耗cpu了

```bash 
sudo mdutil -a -i off/on
```

* 查看端口所在进程

```bash
lsof -i tcp:<port>
```

* 关闭进程

```bash 
kill -9 <pid> 
```

* 通过**netstat**查看端口

```bash
netstat -anp tcp | grep 8080
```
* 查看某个应用

```bash
ps aux | grep java
```
