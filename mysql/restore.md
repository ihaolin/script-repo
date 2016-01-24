# MySQL Import 
* Load data from file

```sql
	use db_name;
	source data_file_path;
```

* Use mysql cmd

```sql
mysql -u.. -p... db_name <  db_name.sql
```
* Maybe we need a script:

```bash
MYSQL_USER="..."
MYSQL_PASSWORD="..."
function restore() {
    echo $1;
    (
        echo "SET AUTOCOMMIT=0;"
        echo "SET UNIQUE_CHECKS=0;"
        echo "SET FOREIGN_KEY_CHECKS=0;"
        cat "$1.sql"
        echo "SET FOREIGN_KEY_CHECKS=1;"
        echo "SET UNIQUE_CHECKS=1;"
        echo "SET AUTOCOMMIT=1;"
        echo "COMMIT;"
    ) | mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$1"
}
```
* Working with **remotes**

```bash
# dump local => remote 
mysqldump --u... -p... --opt source_db  | mysql -u... -p.... --host=target_host target_db

# with ssh remote => local
ssh user@remote_host mysqldump -u... -p... --opt source-db | mysql -u... -p... target_db
# with ssh local to remote
mysqldump -u... -p... source-db | ssh user@remote_host mysql -u... -p... --opt  target_db

# of course, maybe it is a file
# dumping remote => local
ssh user@remote_host 'mysqldump -u... -p... dbname | gzip' > backup-`date +%Y-%m-%d`.sql.gz

# dumping local => remote
mysqldump -u... -p... dbname | gzip | ssh user@remote_host  "cat  > backup-`date +%Y-%m-%d`.sql.gz"
```

* With **netcat**

```bash
# listening on remote  
nc -l 4567 > backup.sql.gz
# dump from local => remote
mysqldump -u... -p... --opt dbname | gzip | nc -w1 remote_host 4567
```
* Restoring from multiple dumps

```bash
for file in `ls *.sql`; 
do  
	echo $file && mysql -u... -p...   "`echo $file | sed "s/\.sql//"`" < $file; 
done

```