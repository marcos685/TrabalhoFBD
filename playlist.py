import pyodbc
cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER=localhost;DATABASE=bdspotper;UID=SA;PWD=Admin123')
cursor = cnxn.cursor()

cursor.execute("SELECT cod, nome FROM album")
albuns_query = cursor.fetchall()

for row in albuns_query:
	print row


print("Entre com o codigo dos albums que contenha musicas que queira inserir em sua playlist,"
	" um de cada vez, seguido de um enter. Quando terminar, entre com -1\n")
cod_album = input()
albuns_selecionados = []
while cod_album != -1:
	albuns_selecionados.append(cod_album)
	cod_album = input()


for album in albuns_selecionados:
	print album
	cursor.execute("SELECT f.numero, f.descricao FROM faixas f, album a WHERE f.cod_album = a.cod")
	for row in cursor.fetchall():
		print row

	print ("entre com os numeros das faixas que deseja inserir na playlist, "
		"uma de cada vez, seguido de um enter. Quando terminar entre com -1 \n")
	numero = input()
	faixas_selecionadas = []
	while numero != -1:
		faixas_selecionadas.append((numero, album)) 
		numero = input()


playlist_nome = input("De um nome para sua playlist:\n")

cursor.execute("SELECT max(cod) FROM playlist")
playlist_cod = 0
if not(cursor.fetchval() is None):
	cursor.fetchval() + 1

#for faixa in faixas_selecionadas:
#	cursor.execute("SELECT tempo_execucao FROM faixas WHERE numero = ? AND cod_album = ?", faixa[0], faixa[1])
#	playlist_tempo += cursor.fetchval()
playlist_tempo = 0

cursor.execute("INSERT INTO playlist (cod, nome) VALUES (?, ?)", 
				playlist_cod, playlist_nome)

for faixa in faixas_selecionadas:
	cursor.execute("INSERT INTO faixa_playlist (faixa_numero, faixa_album, playlist) VAlUES (?, ?, ?)", \
					faixa[0], faixa[1], playlist_cod)

cnxn.commit()
cnxn.close()


