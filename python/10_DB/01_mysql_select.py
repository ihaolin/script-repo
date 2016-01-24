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
query = ('SELECT * FROM tb_course')

# execute sql
cursor.execute(query)

# iterate the results
for (cid, cname, ccredit) in cursor:
    print("Course ID: {}, Course Name: {}, Course Credit:{}"
            .format(cid, cname, ccredit))

# release the resource
cursor.close()
conn.close()
