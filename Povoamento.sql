-- SCRIPT DE ALIMENTAÇÃO DO BANCO
SET search_path TO copa_mundo;
-- 1. Tabelas sem dependências externas diretas
INSERT INTO Patrocinador (Nome, RamoAtuacao) VALUES
('Nike', 'Material Esportivo'),
('Adidas', 'Material Esportivo'),
('Puma', 'Material Esportivo'),
('Coca-Cola', 'Bebidas'),
('Qatar Airways', 'Companhia Aérea'),
('Visa', 'Serviços Financeiros'),
('Budweiser', 'Bebidas'),
('Heineken', 'Bebidas');

INSERT INTO Selecao (Codigo, Nome, AnoFundacao, PatrocinadorNome) VALUES
('BRA', 'Brasil', 1914, 'Nike'), 
('ARG', 'Argentina', 1893, 'Puma'), 
('GER', 'Alemanha', 1900, 'Coca-Cola'),
('FRA', 'França', 1904, 'Heineken'), 
('POR', 'Portugal', 1914, 'Budweiser'), 
('QAT', 'Catar', 1960, 'Qatar Airways'),
('ITA', 'Itália', 1898, 'Visa');

INSERT INTO CopaDoMundo (Ano, PaisSede) VALUES
(2002, 'Coreia do Sul/Japão'), 
(2010, 'África do Sul'), 
(2014, 'Brasil'),
(2018, 'Rússia'), 
(2022, 'Catar');

INSERT INTO Estadio (Nome, Cidade, Capacidade) VALUES
('Maracanã', 'Rio de Janeiro', 78838), 
('Mineirão', 'Belo Horizonte', 61846), 
('Lusail Stadium', 'Lusail', 88966),
('Al Bayt Stadium', 'Al Khor', 68895),
('International Stadium Yokohama', 'Yokohama', 72327),
('Luzhniki Stadium', 'Moscou', 81000),
('Arena de São Paulo', 'São Paulo', 63267);

-- 2. Tabela Pessoa (base para Jogador e Tecnico)
INSERT INTO Pessoa (PessoaID, Nome, DataNascimento) VALUES
-- Jogadores
(1, 'Neymar Jr.', '1992-02-05'), 
(2, 'Lionel Messi', '1987-06-24'), 
(3, 'Cristiano Ronaldo', '1985-02-05'),
(4, 'Kylian Mbappé', '1998-12-20'), 
(5, 'Thomas Müller', '1989-09-13'),
(6, 'Alisson Becker', '1992-10-02'), 
(7, 'Thiago Silva', '1984-09-22'), 
(8, 'Casemiro', '1992-02-23'), 
(9, 'Richarlison', '1997-05-10'), 
(10, 'Vinícius Júnior', '2000-07-12'), 
(11, 'Emiliano Martínez', '1992-09-02'), 
(12, 'Ángel Di María', '1988-02-14'), 
(13, 'Julián Álvarez', '2000-01-31'), 
(14, 'Enzo Fernández', '2001-01-17'), 
(15, 'Javier Mascherano', '1984-06-08'), 
(16, 'Hugo Lloris', '1986-12-26'), 
(17, 'Antoine Griezmann', '1991-03-21'), 
(18, 'Paul Pogba', '1993-03-15'), 
(19, 'N''Golo Kanté', '1991-03-29'), 
(20, 'Olivier Giroud', '1986-09-30'), 
(21, 'Manuel Neuer', '1986-03-27'), 
(22, 'Toni Kroos', '1990-01-04'), 
(23, 'Mesut Özil', '1988-10-15'), 
(24, 'Bastian Schweinsteiger', '1984-08-01'), 
(25, 'Miroslav Klose', '1978-06-09'),
-- Técnicos
(101, 'Tite', '1961-05-25'), 
(102, 'Lionel Scaloni', '1978-05-16'), 
(103, 'Didier Deschamps', '1968-10-15'),
(104, 'Luiz Felipe Scolari', '1948-11-09'), 
(105, 'Joachim Löw', '1960-02-03');

-- 3. Tabelas de Especialização e detalhes
INSERT INTO Jogador (PessoaID, Altura, Peso) VALUES
(1, 1.75, 68.0), 
(2, 1.70, 72.0), 
(3, 1.87, 83.0), 
(4, 1.78, 73.0), 
(5, 1.85, 76.0),
(6, 1.91, 91.0), 
(7, 1.83, 79.0), 
(8, 1.85, 84.0), 
(9, 1.84, 83.0), 
(10, 1.76, 73.0), 
(11, 1.95, 88.0), 
(12, 1.80, 75.0), 
(13, 1.70, 71.0), 
(14, 1.78, 77.0), 
(15, 1.74, 73.0), 
(16, 1.88, 82.0), 
(17, 1.76, 73.0), 
(18, 1.91, 84.0), 
(19, 1.68, 70.0), 
(20, 1.93, 91.0), 
(21, 1.93, 93.0), 
(22, 1.83, 76.0), 
(23, 1.80, 76.0), 
(24, 1.83, 79.0), 
(25, 1.84, 84.0);

INSERT INTO Tecnico (PessoaID) VALUES
(101), 
(102), 
(103), 
(104),
(105);

INSERT INTO Clubes_Treinados (TecnicoPessoaID, NomeClube) VALUES 
-- Tite (ID 101) 
(101, 'Corinthians'), 
(101, 'Grêmio'), 
(101, 'Internacional'), 
-- Lionel Scaloni (ID 102) 
(102, 'Deportivo de La Coruña'), 
(102, 'Sevilla FC (Assistente)'), 
(102, 'SS Lazio (Assistente)'), 
-- Didier Deschamps (ID 103) 
(103, 'Olympique de Marseille'), 
(103, 'AS Monaco'), 
(103, 'Juventus'), 
-- Luiz Felipe Scolari (ID 104) 
(104, 'Palmeiras'), 
(104, 'Grêmio'), 
(104, 'Chelsea'), 
-- Joachim Löw (ID 105) 
(105, 'VfB Stuttgart'), 
(105, 'Fenerbahçe'), 
(105, 'Austria Wien');

-- 4. Relacionamentos e detalhes de Pessoa
INSERT INTO Premiacao (PessoaID, NomePremio, DataConquista) VALUES
(2, 'The Best FIFA Men''s Player', '2023-01-15'), 
(3, 'The Best FIFA Men''s Player', '2017-10-23'),
(2, 'Copa do Mundo FIFA', '2022-12-18'), 
(5, 'Copa do Mundo FIFA', '2014-07-13'),
(2, 'Ballon d''Or', '2023-10-30'),
(3, 'Eurocopa (UEFA)', '2016-07-10');

INSERT INTO Convocacao (JogadorPessoaID, SelecaoCodigo, CopaAno, Posicao) VALUES
(1, 'BRA', 2022, 'Atacante'), 
(2, 'ARG', 2022, 'Atacante'), 
(3, 'POR', 2022, 'Atacante'),
(4, 'FRA', 2022, 'Atacante'),
(4, 'FRA', 2018, 'Atacante'),
(2, 'ARG', 2018, 'Atacante'),
(5, 'GER', 2014, 'Meio-campo'),
(2, 'ARG', 2014, 'Atacante'),
(6, 'BRA', 2022, 'Goleiro'), 
(7, 'BRA', 2022, 'Zagueiro'), 
(7, 'BRA', 2014, 'Zagueiro'),
(8, 'BRA', 2022, 'Meio-campo'),
(9, 'BRA', 2022, 'Atacante'), 
(10, 'BRA', 2022, 'Atacante'), 
(11, 'ARG', 2022, 'Goleiro'), 
(12, 'ARG', 2022, 'Atacante'),
(12, 'ARG', 2018, 'Atacante'),
(13, 'ARG', 2022, 'Atacante'), 
(14, 'ARG', 2022, 'Meio-campo'), 
(15, 'ARG', 2014, 'Meio-campo'), 
(16, 'FRA', 2018, 'Goleiro'), 
(17, 'FRA', 2018, 'Atacante'), 
(18, 'FRA', 2018, 'Meio-campo'), 
(19, 'FRA', 2018, 'Meio-campo'), 
(20, 'FRA', 2022, 'Atacante'), 
(21, 'GER', 2014, 'Goleiro'), 
(22, 'GER', 2014, 'Meio-campo'), 
(23, 'GER', 2014, 'Meio-campo'), 
(24, 'GER', 2014, 'Meio-campo'), 
(25, 'GER', 2014, 'Atacante');

INSERT INTO Comanda (TecnicoPessoaID, SelecaoCodigo, CopaAno) VALUES
(104, 'BRA', 2002), 
(105, 'GER', 2010), 
(105, 'GER', 2014),
(103, 'FRA', 2018), 
(101, 'BRA', 2018), 
(101, 'BRA', 2022), 
(102, 'ARG', 2022);

-- 5. Inserindo Jogos e seus detalhes
INSERT INTO Jogo (JogoID, Horario, Fase, CopaAno, EstadioNome) VALUES
(1, '2014-07-13 16:00:00', 'Final', 2014, 'Maracanã'),
(2, '2022-12-18 12:00:00', 'Final', 2022, 'Lusail Stadium'),
(3, '2014-07-08 17:00:00', 'Semifinal', 2014, 'Mineirão'),
(4, '2002-06-30 20:00:00', 'Final', 2002, 'International Stadium Yokohama'),
(5, '2018-07-15 18:00:00', 'Final', 2018, 'Luzhniki Stadium'),
(6, '2014-07-09 17:00:00', 'Semifinal', 2014, 'Arena de São Paulo');

-- Tabela 'Envolve' (com placar inicial 0)
INSERT INTO Envolve (JogoID, SelecaoCodigo, Placar) VALUES 
-- Jogo 1: Final 2014 (Alemanha vs Argentina) 
(1, 'GER', 0), (1, 'ARG', 0), 
-- Jogo 2: Final 2022 (Argentina vs França) 
(2, 'ARG', 0), (2, 'FRA', 0), 
-- Jogo 3: Semifinal 2014 (Brasil vs Alemanha) 
(3, 'BRA', 0), (3, 'GER', 0), 
-- Jogo 4: Final 2002 (Alemanha vs Brasil) 
(4, 'GER', 0), (4, 'BRA', 0), 
-- Jogo 5: Final 2018 (França vs Argentina) 
(5, 'FRA', 0), (5, 'ARG', 0);
 
-- Tabela 'Atua'
INSERT INTO Atua (JogadorPessoaID, JogoID) VALUES 
-- Jogo 1: Final 2014 (GER vs ARG) 
(5, 1), -- Müller 
(2, 1), -- Messi 
(21, 1), -- Neuer 
(22, 1), -- Kroos 
(15, 1), -- Mascherano 
-- Jogo 2: Final 2022 (ARG vs FRA) 
(2, 2), -- Messi 
(4, 2), -- Mbappé 
(11, 2), -- Emiliano Martínez 
(12, 2), -- Ángel Di María 
(20, 2), -- Olivier Giroud 
(14, 2), -- Enzo Fernández 
-- Jogo 3: Semifinal 2014 (BRA vs GER) 
(5, 3), -- Müller 
(25, 3), -- Miroslav Klose 
(22, 3), -- Toni Kroos 
(7, 3), -- Thiago Silva 
-- Jogo 5: Final 2018 (FRA vs ARG)
(2, 5), -- Messi 
(4, 5), -- Mbappé 
(16, 5), -- Hugo Lloris 
(17, 5), -- Antoine Griezmann 
(18, 5); -- Paul Pogba 

-- 6. Inserindo Gols usando a Stored Procedure
-- Gols da Copa de 2014 
-- Jogo 1 (Final: GER 1x0 ARG). 
CALL registrar_gol(101, 1, 5, 113, 'Normal'); 
-- Jogo 3 (Semifinal: BRA 1x7 GER). 
CALL registrar_gol(102, 3, 5, 11, 'Normal'); 
CALL registrar_gol(103, 3, 25, 23, 'Normal'); 
CALL registrar_gol(104, 3, 22, 24, 'Normal'); 
-- Gols da Copa de 2018 
-- Jogo 5 (Final: FRA 4x2 ARG). 
CALL registrar_gol(201, 5, 17, 38, 'Pênalti'); 
CALL registrar_gol(202, 5, 18, 59, 'Normal'); 
CALL registrar_gol(203, 5, 4, 65, 'Normal'); 
CALL registrar_gol(204, 5, 12, 41, 'Normal'); 
-- Gols da Copa de 2022 
-- Jogo 2 (Final: ARG 3x3 FRA). 
CALL registrar_gol(301, 2, 2, 23, 'Pênalti'); 
CALL registrar_gol(302, 2, 12, 36, 'Normal'); 
CALL registrar_gol(303, 2, 4, 80, 'Pênalti'); 
CALL registrar_gol(304, 2, 4, 81, 'Normal'); 
CALL registrar_gol(305, 2, 2, 108, 'Normal'); 
CALL registrar_gol(306, 2, 4, 118, 'Pênalti'); 
--NOTA: Não há gols para as Copas de 2002 e 2010, pois não temos jogadores em nosso banco que 
--foram convocados para essas edições. Mas basta adicionar, caso queira.
