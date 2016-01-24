# MySql Dump 

* Backup a single database
  NOTE: you can also use the shortcuts -u and -p to specify username and password

```sql
mysqldump --user=... --password=...   your_database_name >  your_database_name.sql
```

* Backup **multiple databases**:

```sql
mysqldump --user=... --password=... --databases db1 db2 > backup.sql
```

* Dump db's tables

```sql
mysqldump -u... -p... db_name t1 t2,.. > dump.sql
```
* or **all the databases** in one shot:

```sql
mysqldump --user=... --password=... --all-databases > backup.sql
```
* Optionally, it's easy to **compress** the backup, for example with **gzip**:

```sql
mysqldump --user=... --password=...   your_database_name | gzip >  your_database_name.sql
```
* And, if your database also has other objects (apart from tables) such as functions,
 views, and stored procedures, you can back them up too with  --routines:
 
```sql
mysqldump --user=... --password=... --routines your_database_name  > your_database_name.sql
```
* It may also be useful to include a timestamp in the target file name, so to know
right away when a backup was taken:

```sql
mysqldump --user=... --password=... your_database_name  > "your_database_name-$(date +%Y-%m-%d-%H.%M.%S).sql"
```

* If you are backing up data with the purpose of restoring it to an instance you want 
 to use as replication slave, then the option --master-data is handy as it adds to 
 the dump the information needed to configure the connection with the replication master:

```sql
mysqldump --user=... --password=... --all-databases --master-data > backup.sql
```

* Only dump schema

```bash
mysqldump -u... -p... --no-data dbname > dbname.sql
```

* Dumping multiple databases, but to separate files

```bash
for db in `mysql -u... -p... -e "show databases;" | tr -d "| "  | egrep -v "(Database|mysql|information_schema)"`; 
do  
	mysqldump -u... -p... --opt --routines --databases $db  > "$db.sql"; 
done
```

