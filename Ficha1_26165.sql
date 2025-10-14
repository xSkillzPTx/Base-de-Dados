/*----------------------------- Ficha 1 -----------------------------*/
1. Liste todos os registos de todos os álbuns (tabela album).

select *
from album;

2. Liste os registos de todas as faixas (tabela faixas), indicando o seu título, bitrate, duração e ano de edição.

select titulo, bitrate, duracao, ano
from faixas;

3.Liste as faixas, título e duração, que têm um bitrate superior a 200 kbit/s ou inferior a 192 kbit/s.

select faixa_id, titulo, duracao
from faixas
where bitrate > 200 or bitrate < 192;

4. Liste o título, o bitrate e a duração para as faixas que sejam a primeira faixa dos diferentes discos, que tenham uma duração superior a 5 minutos mas inferior a 7
minutos e cujo valor de bitrate seja um dos seguintes valores: 128; 256; 320. Não devem ser listadas as faixas que tenham duração nula.

select titulo,bitrate,duracao
from faixas
where faixa_numero = 1 and duracao > 300 and duracao < 420  and duracao!=0 and (bitrate=128 or bitrate=256 or bitrate=320);

5. Sabendo que os atributos criacao e alteracao representam datas em formato Unix Timestamp, aplicando a função FROM_UNIXTIME(), 
liste as faixas que tenham sido criadas entre novembro de 2009 e abril de 2010.

select faixa_id, titulo, DATE(FROM_UNIXTIME(criacao)) as data_criacao 
from faixas 
where DATE(FROM_UNIXTIME(criacao)) BETWEEN '2009-11-01' and '2010-04-30';

6.Liste as faixas (título, data de criação e data de alteração) cuja data de alteração e criação do ficheiro coincidem, 
mas cujo momento (hh:mm:ss) de criação e alteração é diferente.

select titulo, DATE(FROM_UNIXTIME(criacao)) as data_criacao, DATE(FROM_UNIXTIME(alteracao)) as data_alteracao from faixas where DATE(FROM_UNIXTIME(criacao)) = DATE(FROM_UNIXTIME(alteracao)) and TIME(FROM_UNIXTIME(criacao))!=TIME(FROM_UNIXTIME(alteracao));select titulo, DATE(FROM_UNIXTIME(criacao)) as data_criacao, DATE(FROM_UNIXTIME(alteracao)) as data_alteracao
from faixas
where DATE(FROM_UNIXTIME(criacao)) = DATE(FROM_UNIXTIME(alteracao)) and TIME(FROM_UNIXTIME(criacao))!=TIME(FROM_UNIXTIME(alteracao));

7. Liste todas as faixas em que o título comece pela letra Y e termine com a letra S.

select faixa_id, titulo
from faixas
where titulo like "y%s";

8. Liste todas as faixas cujo título contenha a letra “v” na 3ª ou 5ª posição.

select faixa_id, titulo
from faixas
where titulo like "__v%" or titulo like "____v%";

9. Liste todas as faixas que contenham simultaneamente no título os vocábulos "love" e “my”. A ordem pela qual aparecem os vocábulos é irrelevante.

select faixa_id, titulo
from faixas
where titulo like "%_love_%" and titulo like "%_my_%";

10.Liste as faixas ordenadas por ano de edição e duração.

select titulo, ano, duracao
from faixas
order by ano, duracao;

11. Liste as 10 faixas com maior duração

select faixa_id, titulo, duracao
from faixas
order by duracao DESC
limit 10;

12. Liste as 5 faixas com maior bitrate a terem sido editadas em anos pares.

select faixa_id, titulo, bitrate, ano
from faixas
where ano%2=0
order by bitrate desc
limit 5;

13. Liste os títulos das 10 faixas com maior duração e que tenham um bitrate superior a 256.

select faixa_id, titulo, bitrate, duracao 
from faixas 
where bitrate > 256 
order by duracao desc 
limit 10;

14. Liste os títulos e números das faixas que pertencem ao álbum "Revolver".

select f.titulo, f.faixa_id, a.album_id
from faixas f inner join album a on a.album_id=f.album
where a.titulo like "revolver";

15. Liste os títulos das faixas pertencentes aos álbuns editados pelos "Zero 7".

select f.faixa_id, f.titulo, nome
from faixas f inner join album a on f.album = a.album_id
	 inner join artista ar on a.artista = ar.artista_id
where ar.nome like "Zero 7";

16. Dos álbuns editados pelos "Archive" liste os que foram editados de 2000 até ao presente.

select titulo, artista, ano_album
from album a inner join artista ar on a.artista = ar.artista_id
where ar.nome like "Archive" and ano_album >= 2000;

17. Liste para os compositores Benny Andersson e B. Tommy Andersson o nome dos álbuns para os quais compuseram faixas com mais do que 5 minutos 7 de duração.

select f.titulo, a.titulo, duracao, c.nome
from faixas f inner join fx_comp fc on f.faixa_id = fc.faixa_id
	 inner join compositor c on fc.compositor = c.compositor_id
	 inner join album a on f.album = a.album_id
where c.nome in ("Benny Andersson","B. Tommy Andersson") and duracao>300;

18. Liste o nome dos álbuns, que contêm faixas compostas por "Paul McCartney".

select f.titulo, a.titulo ,c.nome
from faixas f inner join fx_comp fc on f.faixa_id = fc.faixa_id
	inner join compositor c on fc.compositor = c.compositor_id
	inner join album a on f.album = a.album_id
where c.nome like "Paul McCartney";

19. Liste as faixas que têm lírica registada.

select f.titulo, l.lyrics
from faixas f inner join letras l on f.faixa_id = l.faixa
where l.lyrics is not null

20. Quais os nomes dos artistas que não têm álbuns editados em seu nome.

select ar.nome, a.album_id
from artista ar left join album a on ar.artista_id = a.artista
where a.album_id is null;

21.Liste todos os compositores das faixas pertencentes aos álbuns editados antes de 1977 pelo artista "John Lennon".

select f.titulo, c.nome, ar.nome, a.titulo, a.ano_album
from compositor c inner join fx_comp fc on c.compositor_id = fc.compositor
	 inner join faixas f on fc.faixa_id = f.faixa_id
	 inner join album a on f.album = a.album_id
	 inner join artista ar on a.artista = ar.artista_id
where ar.nome like "John Lennon" and a.ano_album<1977;

22. Liste todos os álbuns do artista "Wings" que contenham faixas classificadas como "Rock" e que tenham sido escritas por 
um compositor que não seja "Paul McCartney".

select a.titulo, ar.nome, g.name, c.nome
from artista ar inner join album a on ar.artista_id = a.artista
	inner join faixas f on a.album_id = f.album 
	inner join fx_comp fc on  fc.faixa_id = f.faixa_id
	inner join compositor c on c.compositor_id = fc.compositor
	inner join genero g on g.id = f.genero
where ar.nome like "Wings" and g.name like "Rock" and c.nome!="Paul McCartney";