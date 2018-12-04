import pyodbc
cnxn = pyodbc.connect('DRIVER={SQL Server};SERVER=SQLSRV01;DATABASE=DATABASE;UID=USER;PWD=PASSWORD')
cursor = cnxn.cursor()

cursor.execute("SELECT cod, nome FROM album")
albuns_query = cursor.fetchall()

for row in albuns_query:
	print row


print("Entre com o código dos albums que contenha musicas que queira inserir em sua playlist,"
	" um de cada vez, seguido de um enter. Quando terminar, entre com -1")
while cod_album != -1:
	cod_album = input()
	albuns_selecionados.append(cod_album)

for album in albuns_selecionados:
	print album
	cursor.execute("SELECT f.numero, f.descricao FROM faixas f, albuns a WHERE f.cod_album = a.cod")
	for row in cursor.fetchall:
		print row

	print ("entre com os numeros das faixas que deseja inserir na playlist, "
		"uma de cada vez, seguido de um enter. Quando terminar entre com -1")
	while numero != -1:
		numero= input()
		faixas_selecionadas.append((numero, album)) 



