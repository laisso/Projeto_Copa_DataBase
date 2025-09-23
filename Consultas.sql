--Consultas

-- Consulta 1: Total de gols por seleção em uma Copa
SELECT selecao.codigo,
	selecao.nome,
	SUM(envolve.placar) AS GolsTotais
FROM copa_mundo.selecao selecao
JOIN copa_mundo.envolve envolve ON selecao.codigo = envolve.selecaoCodigo
JOIN copa_mundo.jogo jogo ON envolve.jogoid = jogo.jogoid
WHERE jogo.copaano = 2022
GROUP BY selecao.codigo, selecao.nome
ORDER BY GolsTotais DESC;

-- Consulta 2: Top 10 artilheiros na Copa (por ano)
SELECT pessoa.pessoaid, pessoa.nome, COUNT(gol.golid) AS Gols
FROM copa_mundo.gol gol
JOIN copa_mundo.pessoa pessoa ON gol.jogadorpessoaid = pessoa.pessoaid
JOIN copa_mundo.jogo jogo ON gol.jogoid = jogo.jogoid
WHERE jogo.copaano = 2022
GROUP BY pessoa.pessoaid, pessoa.nome
ORDER BY Gols DESC
LIMIT 10;

-- Consulta 3: Média de idade dos jogadores convocados por seleção (em anos)
SELECT convocacao.SelecaoCodigo,
       selecao.Nome AS SelecaoNome,
       ROUND(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, pessoa.DataNascimento)))::numeric, 2) AS MediaIdade
FROM copa_mundo.convocacao 
JOIN copa_mundo.pessoa  ON convocacao.JogadorPessoaID = pessoa.PessoaID
JOIN copa_mundo.selecao  ON convocacao.SelecaoCodigo = selecao.Codigo
WHERE convocacao.CopaAno = 2022
GROUP BY convocacao.SelecaoCodigo, selecao.Nome
ORDER BY MediaIdade;

-- Consulta 4: Número de jogos por estádio (proxy de utilização)
SELECT estadio.nome AS estadio, estadio.cidade, estadio.capacidade, COUNT(jogo.jogoid) AS NumJogos
FROM copa_mundo.estadio
LEFT JOIN copa_mundo.jogo ON estadio.nome = jogo.estadionome
GROUP BY estadio.nome, estadio.cidade, estadio.capacidade
ORDER BY NumJogos DESC, estadio.capacidade DESC;

-- Consulta 5: Seleções sem patrocinador
SELECT Codigo, Nome, AnoFundacao
FROM copa_mundo.selecao
WHERE PatrocinadorNome IS NULL
ORDER BY AnoFundacao;

-- Consulta 6: Gols por seleção por ano de Copa
SELECT jogo.copaano, copadomundo.paissede, selecao.codigo, selecao.nome, SUM(envolve.placar) AS GolsNaCopa
FROM copa_mundo.envolve
JOIN copa_mundo.jogo ON envolve.jogoid = jogo.jogoid
JOIN copa_mundo.selecao ON envolve.selecaoCodigo = selecao.codigo
JOIN copa_mundo.copadomundo ON jogo.copaano = copadomundo.ano
WHERE selecao.codigo = 'BRA'
GROUP BY jogo.copaano, copadomundo.paissede, selecao.codigo, selecao.nome
ORDER BY jogo.copaano;

-- Consulta 7: Jogadores com mais de uma premiação
SELECT pessoa.pessoaid, pessoa.nome, COUNT(*) AS NumPremios
FROM copa_mundo.premiacao
JOIN copa_mundo.pessoa ON premiacao.pessoaid = pessoa.pessoaid
GROUP BY pessoa.pessoaid, pessoa.nome
HAVING COUNT (*) > 1
ORDER BY NumPremios DESC;

-- Consulta 8: Técnicos por número de clubes treinados
SELECT tecnico.pessoaid, pessoa.nome, COUNT (clubes_treinados.nomeClube) AS NumClubes
FROM copa_mundo.Tecnico 
JOIN copa_mundo.pessoa ON tecnico.pessoaid = pessoa.pessoaid
LEFT JOIN copa_mundo.clubes_treinados ON tecnico.pessoaid = clubes_treinados.tecnicopessoaid
GROUP BY tecnico.pessoaid, pessoa.nome
ORDER BY NumClubes DESC;

-- Consulta 9: Jogos decididos por 1 gol
WITH placares AS (
	SELECT jogoid, MAX(Placar) AS maxp, MIN(Placar) AS minp
	FROM copa_mundo.envolve
	GROUP BY jogoid
)
SELECT jogo.jogoid, jogo.horario, jogo.fase, jogo.copaano, placares.maxp,placares.minp
FROM placares 
JOIN copa_mundo.jogo ON jogo.jogoid = placares.jogoid
WHERE (placares.maxp - placares.minp) = 1
ORDER BY jogo.copaano DESC, jogo.horario

-- Consulta 10: Seleções com média de gols por jogo acima de 1.5 (ajustar limiar)
SELECT selecao.Codigo, selecao.Nome,
       SUM(envolve.Placar)::numeric / COUNT(DISTINCT envolve.JogoID) AS MediaGolsPorJogo
FROM copa_mundo.Envolve 
JOIN copa_mundo.Selecao ON envolve.SelecaoCodigo = selecao.Codigo
JOIN copa_mundo.Jogo ON envolve.JogoID = jogo.JogoID
WHERE jogo.CopaAno = 2022
GROUP BY selecao.Codigo, selecao.Nome
HAVING (SUM(envolve.Placar)::numeric / COUNT(DISTINCT envolve.JogoID)) > 1.5
ORDER BY MediaGolsPorJogo DESC;
-- Consulta 11: Contagem de seleções por ramo de atuação do patrocinador
SELECT patrocinador.RamoAtuacao, COUNT(selecao.Codigo) AS NumSelecoes
FROM copa_mundo.Selecao 
JOIN copa_mundo.Patrocinador ON selecao.PatrocinadorNome = patrocinador.Nome
GROUP BY patrocinador.RamoAtuacao
ORDER BY NumSelecoes DESC

-- Consulta 12: Jogadores por número de atuações em uma Copa
SELECT pessoa.PessoaID, pessoa.Nome, COUNT(atua.JogoID) AS PartidasJogadas
FROM copa_mundo.Atua 
JOIN copa_mundo.Pessoa ON atua.JogadorPessoaID = pessoa.PessoaID
JOIN copa_mundo.Jogo ON atua.JogoID = jogo.JogoID
WHERE jogo.CopaAno = 2022
GROUP BY pessoa.PessoaID, pessoa.Nome
ORDER BY PartidasJogadas DESC
LIMIT 20;

-- Consulta 13: Gols onde jogador não consta como tendo atuado no jogo 
SELECT gol.GolID, gol.JogoID, gol.JogadorPessoaID, pessoa.Nome, gol.Minuto
FROM copa_mundo.Gol 
LEFT JOIN copa_mundo.Atua ON atua.JogoID = gol.JogoID AND atua.JogadorPessoaID = gol.JogadorPessoaID
JOIN copa_mundo.Pessoa ON gol.JogadorPessoaID = pessoa.PessoaID
WHERE atua.JogoID IS NULL
ORDER BY gol.JogoID;

-- Consulta 14: Patrocinadores por número de seleções e média de ano de fundação
SELECT patrocinador.Nome AS Patrocinador, COUNT(selecao.Codigo) AS NumSelecoes,
       ROUND(AVG(selecao.AnoFundacao)::numeric,0) AS MediaAnoFundacao
FROM copa_mundo.Patrocinador 
LEFT JOIN copa_mundo.Selecao ON selecao.PatrocinadorNome = patrocinador.Nome
GROUP BY patrocinador.Nome
ORDER BY NumSelecoes DESC;



-- Consulta 15: Jogadores convocados e suas participações/partidas na respectiva Copa
SELECT pessoa.PessoaID, pessoa.Nome, convocacao.SelecaoCodigo, selecao.Nome AS SelecaoNome, COUNT(DISTINCT atua.JogoID) AS PartidasJogadas
FROM copa_mundo.Convocacao 
JOIN copa_mundo.Pessoa ON convocacao.JogadorPessoaID = pessoa.PessoaID
LEFT JOIN copa_mundo.Atua ON atua.JogadorPessoaID = pessoa.PessoaID
LEFT JOIN copa_mundo.Jogo ON atua.JogoID = jogo.JogoID AND jogo.CopaAno = convocacao.CopaAno
JOIN copa_mundo.Selecao ON convocacao.SelecaoCodigo = selecao.Codigo
WHERE convocacao.CopaAno = 2022
GROUP BY pessoa.PessoaID, pessoa.Nome, convocacao.SelecaoCodigo, selecao.Nome
HAVING COUNT(DISTINCT atua.JogoID) > 10
ORDER BY PartidasJogadas DESC;
