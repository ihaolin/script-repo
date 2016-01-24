import gzip

# read
with gzip.open('automake-1.7.4.tar.gz', 'rt') as f:
    text = f.read()
    print(text)

# write, compresslevel higher, performance slower
with gzip.open('automake_backup.gz', 'wt', compresslevel=5) as f:
    f.write(text)

