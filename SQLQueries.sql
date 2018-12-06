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
from 







