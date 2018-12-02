create database bdspotper on
	primary(
	NAME = 'bdspotper',
	FILENAME = 'C:\FBD\bdspotper.mdf',
	SIZE = 5120KB,
	FILEGROWTH = 1024KB
	),
	FILEGROUP bdspotper_fg01
	(
	NAME = 'bdspotper_001',
	FILENAME = 'C:\FBD\bdspotper_001.ndf',
	SIZE = 1024KB,
	FILEGROWTH = 30%
	),
	(
	NAME ='bdspotper_002',
	FILENAME = 'C:\FBD\bdspotper_002.ndf',
	SIZE = 1024KB,
	MAXSIZE = 3072KB,
	FILEGROWTH = 15%
	),
	FILEGROUP bdspotper_fg02
	(
	NAME = 'bdspotper_003',
	FILENAME = 'C:\FBD\bdspotper_003.ndf',
	SIZE = 2048KB,
	MAXSIZE = 5120KB,
	FILEGROWTH = 1024KB
	)

	LOG ON 
	(
	NAME = 'bdspotper_log',
	FILENAME = 'C:\FBD\bdspotper_log.ldf',
	SIZE = 1024KB,
	FILEGROWTH = 10%
	)

-------------------------------------------------------------------------------------------

use bdspotper

CREATE TABLE gravadora(
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
REFERENCES gravadora (cod) ON UPDATE NO ACTION ON DELETE CASCADE
) ON bdspotper_fg01

CREATE TABLE album(
	cod smallint NOT NULL,
	nome nvarchar(50) NOT NULL,
	tipo_gravacao nvarchar(3) NOT NULL,
	data_gravacao datetime NOT NULL,
	cod_gravadora smallint NOT NULL,

	CONSTRAINT album_PK PRIMARY KEY (cod),
	CONSTRAINT album_FK FOREIGN KEY (cod_gravadora)
REFERENCES gravadora (cod) ON UPDATE NO ACTION ON DELETE NO ACTION
) ON bdspotper_fg01

CREATE TABLE comṕosicao(
	cod smallint NOT NULL,
	descricao nvarchar(50) NOT NULL,

	CONSTRAINT composicao_PK PRIMARY KEY (cod)
) ON bdspotper_fg01

CREATE TABLE interprete(
	cod smallint NOT NULL,
	nome nvarchar(50) NOT NULL,
	tipo_interprete nvarchar(50) NOT NULL,

	CONSTRAINT interprete_PK PRIMARY KEY (cod)
) ON bdspotper_fg01

CREATE TABLE periodo_musical(
	cod smallint NOT NULL,
	descricao nvarchar(50) NOT NULL,
	inicio datetime NOT NULL,
	fim datetime NOT NULL,

	CONSTRAINT periodo_PK PRIMARY KEY (cod)
) ON bdspotper_fg01

CREATE TABLE compositor(
	cod smallint NOT NULL,
	nome nvarchar(50) NOT NULL,
	cidade_nascimento nvarchar(50) NOT NULL,
	pais_nascimento nvarchar(50) NOT NULL,
	data_nascimento datetime NOT NULL,
	data_morte datetime NOT NULL,
	cod_periodo smallint NOT NULL,

	CONSTRAINT compositor_PK PRIMARY KEY (cod),
	CONSTRAINT compositor_FK FOREIGN KEY (cod_periodo)
REFERENCES periodo (cod) ON UPDATE NO ACTION ON DELETE NO ACTION
) ON bdspotper_fg01

CREATE TABLE playlist(
	cod smallint NOT NULL,
	nome nvarchar(50) NOT NULL,
	data_criacao  datetime DEFAULT GETDATE(),
	tempo_execucao timestamp NOT NULL,

	CONSTRAINT playlist_PK PRIMARY KEY (cod)
) on bdspotper_fg02

CREATE TABLE faixa(
	numero smallint NOT NULL,
	tempo_execucao timestamp NOT NULL,
	descricao nvarchar(50) NOT NULL,
	cod_album smallint NOT NULL,
	cod_composicao smallint NOT NULL,

	CONSTRAINT faixa_PK PRIMARY KEY NONCLUSTERED (numero, cod_album),
	CONSTRAINT faixa_FK_album FOREIGN KEY (cod_album)
REFERENCES album (cod) ON UPDATE NO ACTION ON DELETE CASCADE,
	CONSTRAINT faixa_FK_composicao FOREIGN KEY (cod_composicao)
REFERENCES composicao (cod) ON UPDATE NO ACTION ON DELETE NO ACTION
) ON bdspotper_fg02

CREATE CLUSTERED INDEX faixa_IDX_album
	ON faixa (cod_album)
	WITH (fillfactor=100, pad_index=on)

CREATE NONCLUSTERED INDEX faixa_IDX_composicao
	ON faixa (cod_composicao)
	WITH (fillfactor=100, pad_index=on)

CREATE TABLE faixa_playlist(
	faixa smallint NOT NULL,
	playlist smallint NOT NULL,
	vezes_tocada smallint DEFAULT 0,
	ultima_vez_tocada datetime,
	
	CONSTRAINT faixa_playlist_PK PRIMARY KEY (faixa, playlist),
	CONSTRAINT faixa_playlist_FX_faixa FOREIGN KEY (faixa)
REFERENCES faixa (cod) ON UPDATE NO ACTION ON DELETE CASCADE,
	CONSTRAINT faixa_playlist_FX_playlist FOREIGN KEY (playlist)
REFERENCES playlist (cod) ON UPDATE NO ACTION ON DELETE CASCADE
) ON bdspotper_fg02

CREATE TABLE faixa_compositor(
	faixa smallint NOT NULL,
	compositor smallint NOT NULL,
	
	CONSTRAINT faixa_compositor_PK PRIMARY KEY (faixa, compositor),
	CONSTRAINT faixa_compositor_FX_faixa FOREIGN KEY (faixa)
REFERENCES faixa (cod) ON UPDATE NO ACTION ON DELETE CASCADE,
	CONSTRAINT faixa_compositor_FX_compositor FOREIGN KEY (compositor)
REFERENCES compositor (cod) ON UPDATE NO ACTION ON DELETE CASCADE
) ON bdspotper_fg01

CREATE TABLE faixa_interprete(
	faixa smallint NOT NULL,
	interprete smallint NOT NULL,
	
	CONSTRAINT faixa_interprete_PK PRIMARY KEY (faixa, interprete),
	CONSTRAINT faixa_interprete_FX_faixa FOREIGN KEY (faixa)
REFERENCES faixa (cod) ON UPDATE NO ACTION ON DELETE CASCADE,
	CONSTRAINT faixa_interprete_FX_interprete FOREIGN KEY (interprete)
REFERENCES interprete (cod) ON UPDATE NO ACTION ON DELETE CASCADE
) ON bdspotper_fg01




		
		

