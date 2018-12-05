create database bdspotper on
	primary(
	NAME = 'bdspotper',
	FILENAME = '/home/marcos/FBD/bdspotper.mdf',
	SIZE = 5120KB,
	FILEGROWTH = 1024KB
	),
	FILEGROUP bdspotper_fg01
	(
	NAME = 'bdspotper_001',
	FILENAME = '/home/marcos/FBD/bdspotper_001.ndf',
	SIZE = 1024KB,
	FILEGROWTH = 30%
	),
	(
	NAME ='bdspotper_002',
	FILENAME = '/home/marcos/FBD/bdspotper_002.ndf',
	SIZE = 1024KB,
	MAXSIZE = 3072KB,
	FILEGROWTH = 15%
	),
	FILEGROUP bdspotper_fg02
	(
	NAME = 'bdspotper_003',
	FILENAME = '/home/marcos/FBD/bdspotper_003.ndf',
	SIZE = 2048KB,
	MAXSIZE = 5120KB,
	FILEGROWTH = 1024KB
	)

	LOG ON 
	(
	NAME = 'bdspotper_log',
	FILENAME = '/home/marcos/FBD/bdspotper_log.ldf',
	SIZE = 1024KB,
	FILEGROWTH = 10%
	)

-------------------------------------------------------------------------------------------

use bdspotper

CREATE TABLE gravadoras(
	cod smallint NOT NULL,
	nome nvarchar(50) NOT NULL,
	homepage nvarchar(50) NOT NULL,
	endereco nvarchar(50) NOT NULL,

	CONSTRAINT gravadora_PK PRIMARY KEY (cod),
) ON bdspotper_fg01

CREATE TABLE telefone_gravadora(
	cod_gravadora smallint NOT NULL,
	numero_telefone smallint NOT NULL,

	CONSTRAINT telefone_gravadora_PK PRIMARY KEY (cod_gravadora, numero_telefone),
	CONSTRAINT telefone_gravadora_Fk FOREIGN Key (cod_gravadora)
REFERENCES gravadoras (cod) ON UPDATE NO ACTION ON DELETE CASCADE
) ON bdspotper_fg01

CREATE TABLE albuns(
	cod smallint NOT NULL,
	nome nvarchar(50) NOT NULL,
	tipo_gravacao nvarchar(3) NOT NULL,
	preco decimal(4,2) NOT NULL,
	data_gravacao date NOT NULL,
	cod_gravadora smallint NOT NULL,

	CONSTRAINT album_PK PRIMARY KEY (cod),
	CONSTRAINT album_FK FOREIGN KEY (cod_gravadora)
REFERENCES gravadoras (cod) ON UPDATE NO ACTION ON DELETE NO ACTION
) ON bdspotper_fg01

CREATE TABLE composicao(
	cod smallint NOT NULL,
	descricao nvarchar(50) NOT NULL,

	CONSTRAINT composicao_PK PRIMARY KEY (cod)
) ON bdspotper_fg01

CREATE TABLE interpretes(
	cod smallint NOT NULL,
	nome nvarchar(50) NOT NULL,
	tipo_interprete nvarchar(50) NOT NULL,

	CONSTRAINT interprete_PK PRIMARY KEY (cod)
) ON bdspotper_fg01

CREATE TABLE periodo_musical(
	cod smallint NOT NULL,
	descricao nvarchar(50) NOT NULL,
	inicio date NOT NULL,
	fim date NOT NULL,

	CONSTRAINT periodo_PK PRIMARY KEY (cod)
) ON bdspotper_fg01

CREATE TABLE compositores(
	cod smallint NOT NULL,
	nome nvarchar(50) NOT NULL,
	cidade_nascimento nvarchar(50) NOT NULL,
	pais_nascimento nvarchar(50) NOT NULL,
	data_nascimento date NOT NULL,
	data_morte date NOT NULL,
	cod_periodo smallint NOT NULL,

	CONSTRAINT compositor_PK PRIMARY KEY (cod),
	CONSTRAINT compositor_FK FOREIGN KEY (cod_periodo)
REFERENCES periodo_musical (cod) ON UPDATE NO ACTION ON DELETE NO ACTION
) ON bdspotper_fg01

CREATE TABLE playlists(
	cod smallint NOT NULL,
	nome nvarchar(50) NOT NULL,
	data_criacao  datetime DEFAULT GETDATE(),
	tempo_execucao time NOT NULL,

	CONSTRAINT playlist_PK PRIMARY KEY (cod)
) on bdspotper_fg02

CREATE TABLE faixas(
	numero smallint NOT NULL,
	tempo_execucao time NOT NULL,
	descricao nvarchar(50) NOT NULL,
	cod_album smallint NOT NULL,
	cod_composicao smallint NOT NULL,

	CONSTRAINT faixa_PK PRIMARY KEY NONCLUSTERED (numero, cod_album),
	CONSTRAINT faixa_FK_album FOREIGN KEY (cod_album)
REFERENCES albuns (cod) ON UPDATE NO ACTION ON DELETE CASCADE,
	CONSTRAINT faixa_FK_composicao FOREIGN KEY (cod_composicao)
REFERENCES composicao (cod) ON UPDATE NO ACTION ON DELETE NO ACTION
) ON bdspotper_fg02

CREATE CLUSTERED INDEX faixa_IDX_album
	ON faixas (cod_album)
	WITH (fillfactor=100, pad_index=on)

CREATE NONCLUSTERED INDEX faixa_IDX_composicao
	ON faixas (cod_composicao)
	WITH (fillfactor=100, pad_index=on)

CREATE TABLE faixa_playlist(
	faixa_numero smallint NOT NULL,
	faixa_album smallint NOT NULL,
	playlist smallint NOT NULL,
	vezes_tocada smallint DEFAULT 0,
	ultima_vez_tocada datetime,
	
	CONSTRAINT faixa_playlist_PK PRIMARY KEY (faixa_numero, faixa_album, playlist),
	CONSTRAINT faixa_playlist_FX_faixa FOREIGN KEY (faixa_numero, faixa_album)
REFERENCES faixas (numero, cod_album) ON UPDATE NO ACTION ON DELETE CASCADE,
	CONSTRAINT faixa_playlist_FX_playlist FOREIGN KEY (playlist)
REFERENCES playlists (cod) ON UPDATE NO ACTION ON DELETE CASCADE
) ON bdspotper_fg02

CREATE TABLE faixa_compositor(
	faixa_numero smallint NOT NULL,
	faixa_album smallint NOT NULL,
	compositor smallint NOT NULL,
	
	CONSTRAINT faixa_compositor_PK PRIMARY KEY (faixa_numero, faixa_album, compositor),
	CONSTRAINT faixa_compositor_FX_faixa FOREIGN KEY (faixa_numero, faixa_album)
REFERENCES faixas (numero, cod_album) ON UPDATE NO ACTION ON DELETE CASCADE,
	CONSTRAINT faixa_compositor_FX_compositor FOREIGN KEY (compositor)
REFERENCES compositores (cod) ON UPDATE NO ACTION ON DELETE CASCADE
) ON bdspotper_fg01

CREATE TABLE faixa_interprete(
	faixa_numero smallint NOT NULL,
	faixa_album smallint NOT NULL,
	interprete smallint NOT NULL,
	
	CONSTRAINT faixa_interprete_PK PRIMARY KEY (faixa_numero, faixa_album, interprete),
	CONSTRAINT faixa_interprete_FX_faixa FOREIGN KEY (faixa_numero, faixa_album)
REFERENCES faixas (numero, cod_album) ON UPDATE NO ACTION ON DELETE CASCADE,
	CONSTRAINT faixa_interprete_FX_interprete FOREIGN KEY (interprete)
REFERENCES interpretes (cod) ON UPDATE NO ACTION ON DELETE CASCADE
) ON bdspotper_fg01

GO
----------------------------------------------------------------------------------
/*CREATE VIEW view_playlists_n_de_albuns(playlist, n_de_albuns)
AS
	SELECT p.nome, count(*)
	FROM playlist p, faixa f, faixa_playlist fp, album a
	WHERE (p.cod=fp.playlist) AND (f.cod=fp.faixa)*/
 
 ---------------------------------------------------------------------------------
CREATE TRIGGER num_faixa_album	ON faixas FOR INSERT, UPDATE
	AS

	IF ((SELECT COUNT(*) FROM faixas f, inserted i WHERE f.cod_album = i.cod_album)>= 64)
	BEGIN
		RAISERROR ('Número maximo de faixas no album excedido', 10, 6)
		ROLLBACK TRANSACTION
	END
GO

---------------------------------------------------------------------------------
CREATE FUNCTION albuns_compositor (@nome_compositor nvarchar(50))
RETURNS @tab_result table(titulo_albuns nvarchar(50))
AS
BEGIN
INSERT INTO @tab_result	
SELECT a.nome
FROM albuns a, faixa_compositor fc, compositores c 
WHERE fc.faixa_album=a.cod and c.cod=fc.compositor and c.nome like @nome_compositor
RETURN
END




		
		

