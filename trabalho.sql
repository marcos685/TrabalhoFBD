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




