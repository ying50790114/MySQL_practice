import mysql.connector

connection = mysql.connector.connect(host='localhost',
                                    port='3306',
                                    user='root',
                                    password='50790114',
                                    database='company_db')

cursor = connection.cursor()

# 取的部門表格所有資料
cursor.execute('select * from `branch`;')

records = cursor.fetchall()
for r in records:
    print(r)

cursor.close()
connection.close()
