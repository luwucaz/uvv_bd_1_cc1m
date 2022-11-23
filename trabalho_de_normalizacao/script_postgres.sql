CREATE DATABASE uvv;

CREATE SCHEMA jogo;

--
-- TABELAS
--

CREATE TABLE jogo.configuracao (
                id_configuracao VARCHAR NOT NULL,
                volume VARCHAR NOT NULL,
                brilho VARCHAR NOT NULL,
                CONSTRAINT configuracao_pk PRIMARY KEY (id_configuracao)
);


CREATE TABLE jogo.imagens_fundo (
                id_configuracao VARCHAR NOT NULL,
                imagem_de_fundo VARCHAR NOT NULL
);


CREATE TABLE jogo.cores (
                id_configuracao VARCHAR NOT NULL,
                cor VARCHAR NOT NULL
);


CREATE TABLE jogo.trilha_sonora (
                id_trilha_sonora VARCHAR NOT NULL,
                nome VARCHAR NOT NULL,
                valencia VARCHAR NOT NULL,
                CONSTRAINT trilha_sonora_pk PRIMARY KEY (id_trilha_sonora)
);


CREATE TABLE jogo.missao (
                id_missao VARCHAR NOT NULL,
                nome VARCHAR NOT NULL,
                descricao VARCHAR NOT NULL,
                tempo_maximo TIME NOT NULL,
                pontuacao INTEGER NOT NULL,
                CONSTRAINT missao_pk PRIMARY KEY (id_missao)
);


CREATE TABLE jogo.jogadores (
                id_jogador VARCHAR NOT NULL,
                nome VARCHAR NOT NULL,
                apelido VARCHAR NOT NULL,
                imagem VARCHAR NOT NULL,
                data_de_registro DATE NOT NULL,
                localizacao VARCHAR,
                CONSTRAINT jogadores_pk PRIMARY KEY (id_jogador)
);


CREATE TABLE jogo.objeto (
                id_objeto VARCHAR NOT NULL,
                nome VARCHAR NOT NULL,
                descricao VARCHAR NOT NULL,
                CONSTRAINT objeto_pk PRIMARY KEY (id_objeto)
);


CREATE TABLE jogo.personagem (
                id_personagem VARCHAR NOT NULL,
                nome VARCHAR NOT NULL,
                imagem VARCHAR NOT NULL,
                CONSTRAINT personagem_pk PRIMARY KEY (id_personagem)
);


CREATE TABLE jogo.cenario (
                id_cenario VARCHAR NOT NULL,
                nome VARCHAR NOT NULL,
                tema VARCHAR NOT NULL,
                CONSTRAINT cenario_pk PRIMARY KEY (id_cenario)
);


CREATE TABLE jogo.nivel (
                id_nivel VARCHAR NOT NULL,
                nome VARCHAR NOT NULL,
                objetivo VARCHAR NOT NULL,
                CONSTRAINT nivel_pk PRIMARY KEY (id_nivel)
);


CREATE TABLE jogo.jogo (
                id_jogo VARCHAR NOT NULL,
                nome VARCHAR NOT NULL,
                objetivo VARCHAR NOT NULL,
                numero_de_niveis INTEGER NOT NULL,
                data_da_criacao DATE NOT NULL,
                id_nivel VARCHAR NOT NULL,
                CONSTRAINT jogo_pk PRIMARY KEY (id_jogo)
);


CREATE TABLE jogo.personalizacao (
                data_da_configuracao DATE NOT NULL,
                hora TIME NOT NULL,
                cor VARCHAR NOT NULL,
                brilho VARCHAR NOT NULL,
                som VARCHAR NOT NULL,
                imagem VARCHAR NOT NULL,
                id_configuracao VARCHAR NOT NULL,
                id_jogo VARCHAR NOT NULL
);


CREATE TABLE jogo.nivel_personagem (
                id_nivel VARCHAR NOT NULL,
                id_personagem VARCHAR NOT NULL
);


CREATE TABLE jogo.composicao (
                posicao_inicial VARCHAR NOT NULL,
                pontos INTEGER NOT NULL,
                id_nivel VARCHAR NOT NULL,
                id_objeto VARCHAR NOT NULL
);


CREATE TABLE jogo.trilha_sonora_nivel (
                id_nivel VARCHAR NOT NULL,
                id_trilha_sonora VARCHAR NOT NULL
);


CREATE TABLE jogo.missao_nivel (
                id_nivel VARCHAR NOT NULL,
                id_missao VARCHAR NOT NULL
);


CREATE TABLE jogo.partidas (
                data_de_inicio DATE NOT NULL,
                data_de_fim DATE NOT NULL,
                hora_de_inicio TIME NOT NULL,
                hora_de_fim TIME NOT NULL,
                pontuacao INTEGER NOT NULL,
                id_jogador VARCHAR NOT NULL,
                id_nivel VARCHAR NOT NULL
);


CREATE TABLE jogo.cenario_nivel (
                id_nivel VARCHAR NOT NULL,
                id_cenario VARCHAR NOT NULL
);


--
-- CHAVES
--

ALTER TABLE jogo.personalizacao ADD CONSTRAINT configuracao_personalizacao_fk
FOREIGN KEY (id_configuracao)
REFERENCES jogo.configuracao (id_configuracao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE jogo.cores ADD CONSTRAINT configuracao_cores_fk
FOREIGN KEY (id_configuracao)
REFERENCES jogo.configuracao (id_configuracao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE jogo.imagens_fundo ADD CONSTRAINT configuracao_imagens_fundo_fk
FOREIGN KEY (id_configuracao)
REFERENCES jogo.configuracao (id_configuracao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE jogo.trilha_sonora_nivel ADD CONSTRAINT trilha_sonora_new_table_2_fk
FOREIGN KEY (id_trilha_sonora)
REFERENCES jogo.trilha_sonora (id_trilha_sonora)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE jogo.missao_nivel ADD CONSTRAINT missao_new_table_1_fk
FOREIGN KEY (id_missao)
REFERENCES jogo.missao (id_missao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE jogo.partidas ADD CONSTRAINT jogadores_partidas_fk
FOREIGN KEY (id_jogador)
REFERENCES jogo.jogadores (id_jogador)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE jogo.composicao ADD CONSTRAINT objeto_composicao_fk
FOREIGN KEY (id_objeto)
REFERENCES jogo.objeto (id_objeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE jogo.nivel_personagem ADD CONSTRAINT personagem_envolvem_fk
FOREIGN KEY (id_personagem)
REFERENCES jogo.personagem (id_personagem)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE jogo.cenario_nivel ADD CONSTRAINT cenario_new_table_fk
FOREIGN KEY (id_cenario)
REFERENCES jogo.cenario (id_cenario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE jogo.cenario_nivel ADD CONSTRAINT nivel_new_table_fk
FOREIGN KEY (id_nivel)
REFERENCES jogo.nivel (id_nivel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE jogo.partidas ADD CONSTRAINT nivel_partidas_fk
FOREIGN KEY (id_nivel)
REFERENCES jogo.nivel (id_nivel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE jogo.missao_nivel ADD CONSTRAINT nivel_new_table_1_fk
FOREIGN KEY (id_nivel)
REFERENCES jogo.nivel (id_nivel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE jogo.trilha_sonora_nivel ADD CONSTRAINT nivel_new_table_2_fk
FOREIGN KEY (id_nivel)
REFERENCES jogo.nivel (id_nivel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE jogo.composicao ADD CONSTRAINT nivel_composicao_fk
FOREIGN KEY (id_nivel)
REFERENCES jogo.nivel (id_nivel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE jogo.nivel_personagem ADD CONSTRAINT nivel_envolvem_fk
FOREIGN KEY (id_nivel)
REFERENCES jogo.nivel (id_nivel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE jogo.jogo ADD CONSTRAINT nivel_jogo_fk
FOREIGN KEY (id_nivel)
REFERENCES jogo.nivel (id_nivel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE jogo.personalizacao ADD CONSTRAINT jogo_personalizacao_fk
FOREIGN KEY (id_jogo)
REFERENCES jogo.jogo (id_jogo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;