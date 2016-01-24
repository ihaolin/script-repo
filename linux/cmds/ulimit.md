# Optimize linux use limit

* 查看所有限制

```bash
ulimit -a 
```

* 修改用户打开的最大进程数

```bash
ulimit -u <max_prog_num>
```

* 修改进程打开的最新文件数

```bash
ulimit -n <max_files_num>
```

* 详细参数
>
```bash
-a 列出所有当前资源极限
-c 设置core文件的最大值.单位:blocks
-d 设置一个进程的数据段的最大值.单位:kbytes
-f Shell 创建文件的文件大小的最大值，单位：blocks
-h 指定设置某个给定资源的硬极限。如果用户拥有 root 用户权限，可以增大硬极限。任何用户均可减少硬极限
-l 可以锁住的物理内存的最大值
-m 可以使用的常驻内存的最大值,单位：kbytes
-n 每个进程可以同时打开的最大文件数
-p 设置管道的最大值，单位为block，1block=512bytes
-s 指定堆栈的最大值：单位：kbytes
-S 指定为给定的资源设置软极限。软极限可增大到硬极限的值。如果 -H 和 -S 标志均未指定，极限适用于以上二者
-t 指定每个进程所使用的秒数,单位：seconds
-u 可以运行的最大并发进程数
-v Shell可使用的最大的虚拟内存，单位：kbytes
-x 文件锁个数
```
