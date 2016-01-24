# 利用awk将csv转换成sql

```bash
cat all.csv | awk -F"," '{printf "INSERT INTO id_card_codes (code, address) VALUES (\x27%s\x27, \x27%s\x27);", $2, $4;print ""}' > id_card_codes.sql
```