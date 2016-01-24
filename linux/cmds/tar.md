# tar command

* create a tar

```bash
tar -cvf tecmint-14-09-12.tar /home/tecmint/
tar cvzf MyImages-14-09-12.tar.gz /home/MyImages
tar cvfj Phpfiles-org.tar.bz2 /home/php
```


* untar a tar

```bash
tar -xvf public_html-14-09-12.tar
tar -xvf public_html-14-09-12.tar -C /home/public_html/videos/
tar -xvf thumbnails-14-09-12.tar.gz
tar -tvf uploadprogress.tar
tar -tvf staging.tecmint.com.tar.gz
tar -tvf Phpfiles-org.tar.bz2
tar -xvf cleanfiles.sh.tar cleanfiles.sh
tar --extract --file=cleanfiles.sh.tar cleanfiles.sh
```
