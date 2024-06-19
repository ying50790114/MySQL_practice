# import mysql.connector
import pymysql

# connection = mysql.connector.connect(host='localhost',
#                                     port='3306',
#                                     user='root',
#                                     password='50790114',
#                                     database='new_db')

connection = pymysql.connect(host='localhost',
                            user='root',
                            password='50790114',
                            database='new_db')

cursor = connection.cursor()



# 新增
cursor.execute("insert into `new_table` values(1, 'cvgip');")
cursor.execute("insert into `new_table` values(2, 'qwert');")
cursor.execute("insert into `new_table` values(3, 'asdfg');")

# cursor.execute("select * from `new_table`;")
# records = cursor.fetchall()
# print(records)

# 修改
cursor.execute("update `new_table` "
               "set `column1` = 5 "
               "WHERE `column2` = 'cvgip';")


# # 刪除
cursor.execute("delete from `new_table` "
               "where `column1` = 5;")


cursor.close()
connection.commit()
connection.close()
