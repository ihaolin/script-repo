# Some useful tips

* list all dbs of mysql

```bash
mysql -uroot -proot -e "show databases;" | tr -d "| " | egrep -v "(Database|mysql|information_schema)"
```