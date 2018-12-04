import pyodbc
cnxn = pyodbc.connect('DRIVER={SQL Server};SERVER=SQLSRV01;DATABASE=DATABASE;UID=USER;PWD=PASSWORD')
cursor = cnxn.cursor()

cursor.execute("SELECT cod, nome FROM album")
albuns_query = cursor.fetchall()

for row in albuns_query:
	print row


print("Entre com o código dos albums que contenha musicas que queira inserir em sua playlist,"
	" um de cada vez, seguido de um enter. Quando terminar, entre com -1\n")
while cod_album != -1:
	cod_album = input()
	albuns_selecionados.append(cod_album)


for album in albuns_selecionados:
	print album
	cursor.execute("SELECT f.numero, f.descricao FROM faixas f, albuns a WHERE f.cod_album = a.cod")
	for row in cursor.fetchall():
		print row

	print ("entre com os numeros das faixas que deseja inserir na playlist, "
		"uma de cada vez, seguido de um enter. Quando terminar entre com -1 \n")
	while numero != -1:
		numero= input()
		faixas_selecionadas.append((numero, album)) 


playlist_nome = input("De um nome para sua playlist:\n")

cursor.execute("SELECT max(cod) FROM playlists")
playlist_cod = cursor.fetchall() + 1

for faixa in faixas_selecionadas:
	cursor.execute("SELECT tempo_execucao FROM faixas WHERE numero = ? AND cod_album = ?", faixa[0], faixa[1])
	playlist_tempo += cursor.fetchall()


cursor.execute("INSERT INTO playlists (cod, nome, tempo_execucao) VALUES (?, ?, ?)", 
				playlist_cod, playlist_nome, playlist_tempo)

for faixa in faixas_selecionadas:
	cursor.execute("INSERT INTO faixa_playlist (faixa_numero, faixa_album, playlist) VAlUES (?, ?, ?)"),
					faixa[0], faixa[1], playlist_cod)


