insert into gravadoras values(1, 'umg', 'umg.com', 'rua 1')
insert into gravadoras values(2, 'wmg', 'wmg.com', 'rua 2')
insert into gravadoras values(3, 'sony', 'sony.com', 'rua 1') 

insert into albuns values(10, 'vol 1', 'ddd', 19.99, '19980204', getdate(), 1) 
insert into albuns values(11, 'vol 2', 'ddd', 19.99, '19980204', getdate(), 1) 
insert into albuns values(12, 'leaves', 'ddd', 19.99, '19980204', getdate(), 3)

insert into albuns values(15, 'altitudes', 'ddd', 59.00, '19980204', getdate(), 2)

insert into periodo_musical values(1000, 'romantico', '1804', '1910') 
insert into periodo_musical values(1001, 'barroco', '1600', '1760')   

insert into compositores values(100, 'chopin',  'paris', 'franca', '18100222', '18491017', 1000) 
insert into compositores values(101, 'beethoven',  'bonn', 'viena', '17701217', '18270326', 1000) 
insert into compositores values(102, 'bach',  'eisenach', 'leipzig', '16850331', '17500726', 1001) 
insert into compositores values(103, 'dvorak',  'nelahozaves', 'imperio austriaco', '18410222', '19041017', 1000)

insert into composicao values(999, 'sonata')
insert into composicao values(998, 'sinfonia')

insert into faixas values(1, '15:00', 'Piano Sonata No. 14', 10, 999) 
insert into faixas values(1, '5:20', 'Fantasie-Impromptu', 11, 999)
insert into faixas values(2, '3:20', 'bourree', 11, 999)
insert into faixas values(1, '4430', 'symphony no 9 in e minor', 15, 998)

insert into faixa_compositor values(1, 10, 101)
insert into faixa_compositor values(1, 11, 100)
insert into faixa_compositor values(2, 11, 102)
insert into faixa_compositor values(1, 15, 103)

insert into playlists values (9999, 'play', getdate(), '6000')
insert into playlists values (9998, 'list', getdate(), '6000')

insert into faixa_playlist values (1, 10, 9999, 0, getdate()) 
insert into faixa_playlist values (1, 10, 9998, 0, getdate()) 
insert into faixa_playlist values (2, 11, 9999, 0, getdate()) 
insert into faixa_playlist values (1, 11, 9999, 0, getdate()) 

insert into faixa_playlist values (1, 12, 9999, 0, getdate()) 
insert into faixa_playlist values (1, 15, 9998, 0, getdate()) 



select avg(a.preco)
		from albuns a

delete from faixa_playlist where playlist=9999