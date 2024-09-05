import sqlite3

connection = sqlite3.connect("dont-panic.db")
cursor = connection.cursor()

password = input("Enter a password: ").strip()

params = (password,)

cursor.execute("UPDATE users SET password = ? WHERE username = 'admin'", params)
connection.commit()
