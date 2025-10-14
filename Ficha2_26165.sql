/*----------------------------- Ficha 2 -----------------------------*/
1. Quantas faixas existem registadas cujo título começa por I ou não contenham título?

select count(titulo) as Faixas
from faixas
where titulo like "I%" or titulo is null;


2. Quantas faixas existem registadas que tenham bitrate superior a 192 kbit/s e não durem mais de 2 minutos?

select count(titulo) as Faixas
from faixas
where bitrate>192 and duracao <= 120;

3. Qual a média de duração das faixas pertencentes aos álbuns dos “Archive” que são do género “Rock”?

select AVG(f.duracao), a.titulo, g.name
from faixas f inner join album a on f.album = a.album_id
	inner join genero g on f.genero = g.id
	inner join artista ar on a.artista = ar.artista_id
where g.name like "Rock" and ar.nome like "Archive";

4. Liste o título de cada álbum e o número de faixas de cada um.

select a.titulo, count(f.faixa_numero) as Numero_faixas
from faixas f inner join album a on f.album = a.album_id
group by a.titulo;

5. Determine para cada artista o número de álbuns editados.

select ar.nome, count(a.titulo) as Numero_Albuns 
from artista ar left join album a on a.artista = ar.artista_id
group by ar.nome;

6. Quais os artistas que editaram álbuns com duração superior a 25 minutos e inferiror a 35 minutos?

select ar.nome, sum(f.duracao)/60 as duracao_album
from artista ar inner join album a on ar.artista_id = a.artista
	inner join faixas f on a.album_id = f.album
group by ar.nome
having duracao_album > 25 and duracao_album < 35;

7. Quais os três artistas que têm em média a menor duração por álbum?

select ar.nome, Sec_to_time(AVG(f.duracao)) as duracao_media
from artista ar inner join album a on ar.artista_id = a.artista
	inner join faixas f on a.album_id = f.album
group by ar.nome
order by duracao_media asc
limit 3;

8. Quais os compositores que participaram em mais do que 15 álbuns?

select c.nome, count(distinct a.album_id) as "Nº de álbuns"
from compositor c inner join fx_comp fc on c.compositor_id=fc.compositor
    inner join faixas f on fc.faixa_id = f.faixa_id
    inner join album a on f.album = a.album_id
group by c.nome
having count(distinct a.album_id)>15;

9. Quantas faixas existem cujo título se inicia por “My”, por “Love” ou que termina em ”Love”?

select
	(select count(*) from faixas where titulo like "My%") as "Começa por My",
	(select count(*) from faixas where titulo like "Love%") as "Começa por Love",
	(select count(*) from faixas where titulo like "%Love") as "Termina em Love";
	

10. Quais os álbuns, cujas faixas pertencem a mais do que um género?

select a.titulo
from album a
where a.album_id in (
	select f.album
	from faixas f
	group by f.album
	having count(distinct f.genero) > 1
);

11. Das faixas que foram editadas após 1980, quais são as que pertencem aos dez álbuns mais com mais faixas?

select f.faixa_id, f.titulo, a.titulo, a.ano_album
from faixas f 
inner join album a on f.album = a.album_id
inner join (
    select f2.album
    from faixas f2 
    inner join album a2 on f2.album = a2.album_id
    where a2.ano_album > 1980
    group by f2.album
    order by count(f2.faixa_id) DESC
    limit 10
) as top on a.album_id = top.album
order by f.faixa_id;

12.Crie uma consulta que mostre quais os compositores que, pertencendo ao TOP 10 da “produtividade” (ou seja, que compuseram mais faixas musicais), compuseram
músicas que figuram nos álbuns que estão no TOP 50 da duração (ou seja, os 50 álbuns mais longos).

select distinct c.nome
from compositor c inner join fx_comp fc on c.compositor_id = fc.compositor
	inner join faixas f on fc.faixa_id = f.faixa_id
	inner join (
		select compositor
		from fx_comp
		group by compositor
		order by count(faixa_id) desc
		limit 10
	) as top_10 on c.compositor_id = top_10.compositor
    inner join (
        select album, sum(duracao) as duracao_total
        from faixas
        GROUP by album
        order by duracao_total DESC
        limit 50
    ) as top_50 on f.album = top_50.album;
    

13.Quais os álbuns em que pelo menos metade das faixas tem duração superior à duração média de todas as faixas.

select a.titulo,
	(select count(*) 
     from faixas f2 
     where f2.album = a.album_id
     and f2.duracao > (select avg(duracao) from faixas where duracao is not null)) as faixas_acima_media
from album a inner join faixas f on a.album_id = f.album
group by a.album_id, a.titulo
having faixas_acima_media >= count(f.faixa_id) / 2  
ORDER BY `a`.`titulo` ASC

14.Quais os artistas que editaram álbuns que têm pelo menos três géneros musicais representados?

select

15.Quais foram os artistas que editaram álbuns, cujas faixas não estão creditadas no mesmo ano.

select

16.Crie uma consulta que permita conhecer quais os álbuns (se existirem) que são constituídos por faixas em que todos os compositores sejam diferentes.
Nota:aconselha-se a utilização da função GROUP_CONCAT.

select

17.Qual o compositor que compôs faixas para um maior número de álbuns.

select

18.Qual o compositor que compôs faixas para um maior número de artistas que editaram álbuns.

select

19.Quais os artistas que editaram pelo menos 10 álbuns num período de atividade do artista de pelo menos 15 anos.

select

20.Dos álbuns que contêm faixas compostas simultaneamente por John Lennon (compositor_id=140) e Paul McCartney (compositor_id=139) quais são os que foram
editados pelos "The Beatles" depois de 1967 e que contenham pelo menos 2 faixas compostas por George Harrison (compositor_id=141).

select

21.Quais os artistas que têm pelo menos 2 álbuns editados, em que na totalidade das faixas não tenha sido creditado como compositor o próprio artista. 
(Nota: considere apenas igualdade nos nomes. Compositor "Lennon"<>Artista "John Lennon")

select

