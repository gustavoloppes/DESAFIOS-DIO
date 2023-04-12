-- 1 BUSCAR NOME E ANO DE DOS FILMES
SELECT	Nome, Ano 
FROM Filmes


-- 2 BUSCAR NOME E NO DOS FILMES ORDENADOS POR CRES PELO ANO
SELECT Nome,Ano, Duracao 
FROM Filmes
ORDER BY Ano ASC

-- 3 BUSCAR PELO FILME DE VOLTA PARA O FUTURO, TRAZENDO O NOME/ANO/DURAC
SELECT Nome,Ano,Duracao
FROM Filmes
WHERE Nome = 'De Volta Para o Futuro'


-- 4 BUSCAR OS FILMES LANCADOS EM 1997
SELECT Nome,Ano,Duracao
FROM Filmes
WHERE Ano = '1997'


-- 5 BUSCAR OS FILMES LANCADOS APOS O ANO DE 2000
SELECT Nome,Ano,Duracao
FROM Filmes
WHERE Ano > '2000'


-- 6 Buscar os filmes com a duracao maior que 100 e menor que 150, 
-- ordenando pela duracao em ordem crescente
SELECT Nome,Ano,Duracao
FROM Filmes
WHERE Duracao > '100' AND Duracao < '150'
ORDER BY Duracao ASC

-- 7 QUANTIDA FILME LANCADOS NO ANO, AGRUPANDO POR ANO, ORDENANDO POR DURAC DESC
SELECT 
	Ano,
	count(Ano) AS Quantidade
FROM Filmes
GROUP BY Ano
ORDER BY Quantidade DESC


-- 8 Buscar os Atores do gênero masculino, 
-- retornando o PrimeiroNome, UltimoNome
SELECT PrimeiroNome, UltimoNome
FROM Atores
WHERE Genero = 'M'


-- 9 Buscar os Atores do gênero feminino, retornando o PrimeiroNome, 
-- UltimoNome, e ordenando pelo PrimeiroNome
SELECT PrimeiroNome, UltimoNome
FROM Atores
WHERE Genero = 'F'
ORDER BY PrimeiroNome


-- 10 Buscar o nome do filme e o gênero
SELECT F.Nome AS NOME, G.Genero AS GENERO
FROM Filmes F INNER JOIN Generos G ON F.Id = G.Id
WHERE G.Genero = 'Mistério' 


-- 11 Buscar o nome do filme e o gênero do tipo "Mistério"
SELECT F.Nome AS NOME, G.Genero AS GENERO
FROM Filmes F INNER JOIN Generos G ON F.Id = G.Id
WHERE G.Genero = 'Mistério' 


-- 12 Buscar o nome do filme e os atores, trazendo o 
-- PrimeiroNome, UltimoNome e seu Papel
SELECT F.Nome AS NomeFilme, A.PrimeiroNome, A.UltimoNome
FROM Filmes F INNER JOIN Atores A ON F.Id = A.Id  