# Some options for dump and restore

+ add-locks
>
Affects restores: this option ensures that each table is locked while restoring, so to allow dropping and recreating the tables. At the same time, because a table remains locked to other transactions while restoring the data, inserts happen more quickly, therefore reducing the time taken to restore the content of the table.
+ create-options
> 
Affects restores: makes the creation of a table quicker by merging into the CREATE TABLE statement anything that has to do with defining the structure of the table.

+ disable-keys
>
Affects restores: it helps when restoring databases using MyISAM as storage engine. Delays the creation of the indexes for a table until all the data in that table has been restored. This results in an overall faster restore of the table vs updating indexes while restoring the data.

+ extended-insert
>
Affects both dumps and restores: this can speed up A LOT restores, as it produces in the final SQL dump INSERT commands with multiple sets of values, resulting in the insertion of multiple rows at once. As a side benefit vs having a separate INSERT statement for each row, the resulting SQL dump will also be smaller, taking up less storage space.

+ lock-tables
>
Affects dumps: improves dumping of MyISAM tables, by locking all the tables during the dump.

+ quick
>
Affects dumps: when dumping large tables, this option prevents buffering the whole tables before dumping them to the backup file. Instead, rows are fetched and dumped right away to file, resulting in an overall faster and lighter dump thanks to reduced load on the system.
- See more at: 
>
[http://vitobotta.com/smarter-faster-backups-restores-mysql-databases-with-mysqldump/#sthash.C2lePyIh.dpuf]()