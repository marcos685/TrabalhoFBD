SELECT * from albuns a where a.preco > (select avg(preco) from albuns)

select * from faixa_compositor fc inner join faixa_playlist fp on fc.faixa_numero=fp.faixa_numero and fc.faixa_album=fp.faixa_album 