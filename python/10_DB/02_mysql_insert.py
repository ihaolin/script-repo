import mysql.connector

#create connection object
conn = mysql.connector.connect(
    user='root',
    password='root',
    host='127.0.0.1',
    database='stu_grade'
)
#create a cursor object
cursor = conn.cursor()

# sql
# sql = ('INSERT INTO tb_course '
#        '(cid, cname, ccredit) '
#        'VALUES (%s, %s, %s)')

# data, inserted
#course = ('81', 'Osgi', 3.5)

# other form
sql = ('INSERT INTO tb_course '
       '(cid, cname, ccredit) '
       'VALUES (%(cid)s, %(cname)s, %(ccredit)s)')

course = {
    'cid' : '81',
    'cname' : 'osgi',
    'ccredit' : 3.5
}

# execute sql
cursor.execute(sql, course)

# make sure data is committed
conn.commit()

# release the resource
cursor.close()
conn.close()
