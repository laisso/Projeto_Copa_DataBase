-- SCRIPT DE CRIAÇÃO DAS TABELAS (TAREFA 2)
DROP SCHEMA IF EXISTS copa_mundo CASCADE;
CREATE SCHEMA copa_Mundo;
SET search_path TO copa_mundo;
-- Limpa o ambiente, se necessário 
DROP TABLE IF EXISTS Gol, Atua, Envolve, Jogo, Estadio, Convocacao, Comanda, Premiacao, Clubes_Treinados, Tecnico, Jogador, Pessoa, CopaDoMundo, Selecao, Patrocinador, Auditoria_Patrocinio CASCADE;

-- Entidade Patrocinador
CREATE TABLE Patrocinador (
    Nome VARCHAR(100) PRIMARY KEY,
    RamoAtuacao VARCHAR(100) NOT NULL
);

-- Entidade Selecao
CREATE TABLE Selecao (
    Codigo CHAR(3) PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL UNIQUE,
    AnoFundacao INT,
    PatrocinadorNome VARCHAR(100) UNIQUE,
    FOREIGN KEY (PatrocinadorNome) REFERENCES Patrocinador(Nome) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Entidade CopaDoMundo
CREATE TABLE CopaDoMundo (
    Ano INT PRIMARY KEY,
    PaisSede VARCHAR(50) NOT NULL
);

-- Entidade Estadio
CREATE TABLE Estadio (
    Nome VARCHAR(100) PRIMARY KEY,
    Cidade VARCHAR(100) NOT NULL,
    Capacidade INT
);

-- Entidade Jogo
CREATE TABLE Jogo (
    JogoID INTEGER PRIMARY KEY, 
    Horario TIMESTAMP NOT NULL,
    Fase VARCHAR(50),
    CopaAno INT NOT NULL,
    EstadioNome VARCHAR(100),
    FOREIGN KEY (CopaAno) REFERENCES CopaDoMundo(Ano) ON DELETE CASCADE,
    FOREIGN KEY (EstadioNome) REFERENCES Estadio(Nome) ON DELETE SET NULL
);

-- Relacionamento M:N 'Envolve' entre Jogo e Selecao
CREATE TABLE Envolve (
    JogoID INT,
    SelecaoCodigo CHAR(3),
    Placar INT NOT NULL,
    PRIMARY KEY (JogoID, SelecaoCodigo),
    FOREIGN KEY (JogoID) REFERENCES Jogo(JogoID) ON DELETE CASCADE,
    FOREIGN KEY (SelecaoCodigo) REFERENCES Selecao(Codigo) ON DELETE CASCADE
);

-- Generalização Pessoa
CREATE TABLE Pessoa (
    PessoaID INTEGER PRIMARY KEY, 
    Nome VARCHAR(150) NOT NULL,
    DataNascimento DATE NOT NULL
);

-- Especialização Jogador
CREATE TABLE Jogador (
    PessoaID INT PRIMARY KEY,
    Altura DECIMAL(3,2),
    Peso DECIMAL(5,2),
    FOREIGN KEY (PessoaID) REFERENCES Pessoa(PessoaID) ON DELETE CASCADE
);

-- Especialização Técnico
CREATE TABLE Tecnico (
    PessoaID INT PRIMARY KEY,
    FOREIGN KEY (PessoaID) REFERENCES Pessoa(PessoaID) ON DELETE CASCADE
);

-- Atributo Multivalorado de Tecnico
CREATE TABLE Clubes_Treinados (
    TecnicoPessoaID INT,
    NomeClube VARCHAR(100),
    PRIMARY KEY (TecnicoPessoaID, NomeClube),
    FOREIGN KEY (TecnicoPessoaID) REFERENCES Tecnico(PessoaID) ON DELETE CASCADE
);

-- Entidade Fraca Premiacao
CREATE TABLE Premiacao (
    PessoaID INT,
    NomePremio VARCHAR(100),
    DataConquista DATE,
    PRIMARY KEY (PessoaID, NomePremio, DataConquista),
    FOREIGN KEY (PessoaID) REFERENCES Pessoa(PessoaID) ON DELETE CASCADE
);

-- Relacionamento M:N para Convocação
CREATE TABLE Convocacao (
    JogadorPessoaID INT,
    SelecaoCodigo CHAR(3),
    CopaAno INT,
    Posicao VARCHAR(50) NOT NULL,
    PRIMARY KEY (JogadorPessoaID, SelecaoCodigo, CopaAno),
    FOREIGN KEY (JogadorPessoaID) REFERENCES Jogador(PessoaID) ON DELETE CASCADE,
    FOREIGN KEY (SelecaoCodigo) REFERENCES Selecao(Codigo) ON DELETE CASCADE,
    FOREIGN KEY (CopaAno) REFERENCES CopaDoMundo(Ano) ON DELETE CASCADE
);

-- Relacionamento M:N para Comando Técnico
CREATE TABLE Comanda (
    TecnicoPessoaID INT,
    SelecaoCodigo CHAR(3),
    CopaAno INT,
    PRIMARY KEY (TecnicoPessoaID, SelecaoCodigo, CopaAno),
    FOREIGN KEY (TecnicoPessoaID) REFERENCES Tecnico(PessoaID) ON DELETE CASCADE,
    FOREIGN KEY (SelecaoCodigo) REFERENCES Selecao(Codigo) ON DELETE CASCADE,
    FOREIGN KEY (CopaAno) REFERENCES CopaDoMundo(Ano) ON DELETE CASCADE
);

-- Relacionamento M:N 'Atua' para Atuação em Jogo
CREATE TABLE Atua (
    JogadorPessoaID INT,
    JogoID INT,
    PRIMARY KEY (JogadorPessoaID, JogoID),
    FOREIGN KEY (JogadorPessoaID) REFERENCES Jogador(PessoaID) ON DELETE CASCADE,
    FOREIGN KEY (JogoID) REFERENCES Jogo(JogoID) ON DELETE CASCADE
);

-- Entidade Fraca Gol
CREATE TABLE Gol (
    GolID INTEGER PRIMARY KEY, 
    JogoID INT NOT NULL,
    JogadorPessoaID INT NOT NULL,
    Minuto INT,
    Tipo VARCHAR(20) DEFAULT 'Normal',
    FOREIGN KEY (JogoID) REFERENCES Jogo(JogoID) ON DELETE CASCADE,
    FOREIGN KEY (JogadorPessoaID) REFERENCES Jogador(PessoaID) ON DELETE SET NULL
);
-- Apenas a tabela de auditoria terá ID automático para simplificar o log. (SERIAL)
-- Mantive como SERIAL porque ele é um identificador de sistema, não de usuário, e é gerado por um processo automático, não manual.

-- TRIGGER
CREATE TABLE Auditoria_Patrocinio (
    LogID SERIAL PRIMARY KEY, 
    SelecaoCodigo CHAR(3),
    PatrocinadorAntigo VARCHAR(100),
    PatrocinadorNovo VARCHAR(100),
    DataAlteracao TIMESTAMP NOT NULL
);

CREATE OR REPLACE FUNCTION log_troca_patrocinador()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.PatrocinadorNome IS DISTINCT FROM NEW.PatrocinadorNome THEN
        INSERT INTO Auditoria_Patrocinio (SelecaoCodigo, PatrocinadorAntigo, PatrocinadorNovo, DataAlteracao)
        VALUES (NEW.Codigo, OLD.PatrocinadorNome, NEW.PatrocinadorNome, now());
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_audita_patrocinio
AFTER UPDATE ON Selecao
FOR EACH ROW
EXECUTE FUNCTION log_troca_patrocinador();

-- STORED PROCEDURE
CREATE OR REPLACE PROCEDURE registrar_gol(
    p_gol_id INT, -- MUDANÇA: Novo parâmetro para o ID do gol
    p_jogo_id INT,
    p_jogador_id INT,
    p_minuto INT,
    p_tipo_gol VARCHAR(20)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_selecao_codigo CHAR(3);
BEGIN
    SELECT c.SelecaoCodigo INTO v_selecao_codigo
    FROM Convocacao c
    JOIN Jogo j ON c.CopaAno = j.CopaAno
    WHERE c.JogadorPessoaID = p_jogador_id AND j.JogoID = p_jogo_id
    LIMIT 1;
    IF FOUND THEN
        INSERT INTO Gol (GolID, JogoID, JogadorPessoaID, Minuto, Tipo)
        VALUES (p_gol_id, p_jogo_id, p_jogador_id, p_minuto, p_tipo_gol);
        UPDATE Envolve
        SET Placar = Placar + 1
        WHERE JogoID = p_jogo_id AND SelecaoCodigo = v_selecao_codigo;
    ELSE
        RAISE EXCEPTION 'Jogador com ID % não pode marcar no jogo ID % pois não foi convocado para a respectiva copa.', p_jogador_id, p_jogo_id;
    END IF;
END;
$$;
