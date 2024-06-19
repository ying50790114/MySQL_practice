import mysql.connector

connection = mysql.connector.connect(host='localhost',
                                    port='3306',
                                    user='root',
                                    password='50790114')

cursor = connection.cursor()

# 創建資料庫
cursor.execute('create database `new_db`;')


# 取得所有資料庫名稱
cursor.execute('show databases;')
records = cursor.fetchall()
for r in records:
    print(r)


# 選擇資料庫
cursor.execute('use `new_db`;')


# 創建表格
cursor.execute('create table `new_table`('
               '`column1` int primary key,'
               '`column2` varchar(10)'
               ');')

cursor.execute('describe `new_table`;')
records = cursor.fetchall()
for r in records:
    print(r)


cursor.close()
connection.close()
