SELECT * 
from albuns a 
where a.preco > (select avg(preco) from albuns)

select top 1 c.nome 
from faixa_compositor fc, compositores c, faixa_playlist fp 
where fc.faixa_numero=fp.faixa_numero and
	  fc.faixa_album=fp.faixa_album and 
	  c.cod = fc.compositor 
group by c.nome 
order by count(compositor) desc

select top 1 g.nome
from faixa_playlist fp, faixa_compositor fc, compositores c, albuns a, gravadoras g 
where fp.faixa_album=fc.faixa_album and
	  fp.faixa_numero=fc.faixa_numero and
	  fc.compositor = c.cod and
	  fp.faixa_album = a.cod and 
	  a.cod_gravadora = g.cod and
	  c.nome like 'dvorak'
group by g.nome
order by count(fp.playlist) desc

select *
from faixas f, faixa_compositor fc, compositores c, periodo_musical pm, faixa_playlist fp, playlists p, composicao cp
where f.numero = fc.faixa_numero and
	  f.cod_album = fc.faixa_album and
	  f.cod_composicao = cp.cod and
	  c.cod = fc.compositor and
	  c.cod_periodo = pm.cod and 
	  fp.faixa_album = f.cod_album and
	  fp.faixa_numero = f.numero and
	  fp.playlist = p.cod and
	  pm.descricao = 'romantico' and
	  cp.descricao = 'sinfonia'

select * from faixa_playlist
	  
	







