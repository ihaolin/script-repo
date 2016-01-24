# 监控nproc

+ 查看各用户所运行的nproc数(包括进程和线程数):

    ```bash
    ps h -Led -o user | sort | uniq -c | sort -n
    ```

+ 查看某用户运行nproc数:

    ```bash
    ps -o nlwp,pid,lwp,args -u {user_name} | sort -nr
    ```
    