# 访问日志监控

```bash

# 响应码排序
cat access.log | cut -d '"' -f3 | cut -d ' ' -f2 | sort | uniq -c | sort -r

# 各种请求响应码统计
awk '{print $9}' access.log | sort | uniq -c | sort -r

# 查询某些错误的请求，如404
awk '($9 ~ /404/)' access.log | awk '{print $7}' | sort | uniq -c | sort -r

```