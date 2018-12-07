import pyodbc
cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER=localhost;DATABASE=bdspotper;UID=SA;PWD=Admin123')
cursor = cnxn.cursor()

cursor.execute("SELECT * FROM albuns")
for row in cursor.fetchall():
    print row

album_dscr = input("Entre com parte da descricao do "
                    "album a ser editado\n")

cursor.execute("SELECT a.cod FROM albuns a WHERE a.nome like ?", album_dscr)
cod_album = cursor.fetchval()
print cod_album

print ("Entre com o atributo que deseja alterar\n")
print ("1 - Nome\n")
print ("2 - Data de gravacao\n")
print ("3 - Gravadora\n")

sel = input()
val = None
if sel == 1:
    val = input("Entre com o novo nome")
    cursor.execute("UPDATE albuns SET nome=? WHERE cod=?", val, cod_album)
elif sel == 2:
    val = input("Entre com a nova data de gravacao")
    cursor.execute("UPDATE albuns SET data_gravacao=? WHERE cod=?", val, cod_album)

elif sel == 3:

    cursor.execute("SELECT cod, nome FROM gravadoras")
    for row in cursor.fetchall():
        print row

    val = input("Entre com o novo codigo da nova gravadora")
    cursor.execute("UPDATE albuns SET cod_gravadora=? WHERE cod=?", val, cod_album)
    

cnxn.commit()
cnxn.close()    



