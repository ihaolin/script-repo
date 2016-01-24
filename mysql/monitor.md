# Monitor

* 查看线程状态：

```sql
mysqladmin ext -i1 | awk '
/Queries/{q=$4-qp;qp=$4}
/Threads_connected/{tc=$4}
/Threads_running/{printf "%5d %5d %5d\n", q, tc, $4}'
```

 * 查看mysql进程状态

 ```sql
mysql -e 'SHOW PROCESSLIST\G' | grep State: | sort | uniq -c | sort -rn 
```