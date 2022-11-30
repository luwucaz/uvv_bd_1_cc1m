--
-- TABELAS
--

CREATE TABLE cc1mg8.cargo (
                id_cargo INTEGER NOT NULL,
                cargo VARCHAR NOT NULL,
                salario_minimo NUMERIC(8,2) NOT NULL,
                salario_maximo NUMERIC(8,2) NOT NULL,
                CONSTRAINT cargo_pk PRIMARY KEY (id_cargo)
);


CREATE TABLE cc1mg8.departamento (
                id_departamento INTEGER NOT NULL,
                nome VARCHAR NOT NULL,
                CONSTRAINT departamento_pk PRIMARY KEY (id_departamento)
);


CREATE TABLE cc1mg8.funcionario (
                id_funcionario INTEGER NOT NULL,
                id_departamento INTEGER NOT NULL,
                id_cargo INTEGER NOT NULL,
                cpf NUMERIC(11) NOT NULL,
                nome VARCHAR NOT NULL,
                email VARCHAR NOT NULL,
                senha VARCHAR NOT NULL,
                telefone INTEGER NOT NULL,
                data_contratacao DATE NOT NULL,
                data_de_inicio DATE NOT NULL,
                salario NUMERIC(8,2) NOT NULL,
                ativo BOOLEAN NOT NULL,
                CONSTRAINT funcionario_pk PRIMARY KEY (id_funcionario)
);


CREATE TABLE cc1mg8.historico_cargo (
                id_departamento INTEGER NOT NULL,
                id_cargo INTEGER NOT NULL,
                id_funcionario INTEGER NOT NULL,
                salario NUMERIC(8,2) NOT NULL,
                data_de_inicio DATE NOT NULL,
                data_de_fim DATE,
                CONSTRAINT historico_cargo_pk PRIMARY KEY (id_departamento, id_cargo, id_funcionario)
);


CREATE TABLE cc1mg8.tipo_lixo (
                id_tipo_lixo INTEGER NOT NULL,
                tipo VARCHAR NOT NULL,
                CONSTRAINT tipo_lixo_pk PRIMARY KEY (id_tipo_lixo)
);


CREATE TABLE cc1mg8.veiculo (
                id_veiculo INTEGER NOT NULL,
                placa VARCHAR NOT NULL,
                descricao VARCHAR,
                ativo BOOLEAN NOT NULL,
                CONSTRAINT veiculo_pk PRIMARY KEY (id_veiculo)
);


CREATE TABLE cc1mg8.cliente (
                id_cliente INTEGER NOT NULL,
                cpf NUMERIC(11) NOT NULL,
                nome VARCHAR NOT NULL,
                email VARCHAR NOT NULL,
                senha VARCHAR NOT NULL,
                telefone VARCHAR NOT NULL,
                ativo BOOLEAN NOT NULL,
                CONSTRAINT cliente_pk PRIMARY KEY (id_cliente)
);


CREATE TABLE cc1mg8.endereco (
                id_endereco INTEGER NOT NULL,
                id_cliente INTEGER NOT NULL,
                rua VARCHAR NOT NULL,
                bairro VARCHAR NOT NULL,
                cep NUMERIC(6) NOT NULL,
                numero INTEGER NOT NULL,
                complemento VARCHAR,
                ativo BOOLEAN NOT NULL,
                CONSTRAINT endereco_pk PRIMARY KEY (id_endereco)
);


CREATE TABLE cc1mg8.pedidos (
                id_pedido INTEGER NOT NULL,
                id_endereco INTEGER NOT NULL,
                data_solicitacao DATE NOT NULL,
                data_pedido DATE NOT NULL,
                hora_inicial TIME NOT NULL,
                hora_final TIME,
                atendido BOOLEAN NOT NULL,
                ativo BOOLEAN NOT NULL,
                CONSTRAINT pedidos_pk PRIMARY KEY (id_pedido)
);


CREATE TABLE cc1mg8.atendimento (
                id_pedido INTEGER NOT NULL,
                id_funcionario INTEGER NOT NULL,
                id_veiculo INTEGER NOT NULL,
                id_tipo_lixo INTEGER NOT NULL,
                data_atendimento DATE NOT NULL,
                ativo BOOLEAN NOT NULL,
                coleta_finalizada BOOLEAN NOT NULL,
                visita_feita BOOLEAN NOT NULL,
                obs VARCHAR NOT NULL,
                CONSTRAINT atendimento_pk PRIMARY KEY (id_pedido, id_funcionario, id_veiculo, id_tipo_lixo)
);


--
-- CHAVES
--

ALTER TABLE cc1mg8.funcionario ADD CONSTRAINT cargo_funcionario_fk
FOREIGN KEY (id_cargo)
REFERENCES cc1mg8.cargo (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cc1mg8.historico_cargo ADD CONSTRAINT cargo_historico_cargo_fk
FOREIGN KEY (id_cargo)
REFERENCES cc1mg8.cargo (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cc1mg8.historico_cargo ADD CONSTRAINT departamento_historico_cargo_fk
FOREIGN KEY (id_departamento)
REFERENCES cc1mg8.departamento (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cc1mg8.funcionario ADD CONSTRAINT departamento_funcionario_fk
FOREIGN KEY (id_departamento)
REFERENCES cc1mg8.departamento (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cc1mg8.atendimento ADD CONSTRAINT funcionario_atendimento_fk
FOREIGN KEY (id_funcionario)
REFERENCES cc1mg8.funcionario (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cc1mg8.historico_cargo ADD CONSTRAINT funcionario_historico_cargo_fk
FOREIGN KEY (id_funcionario)
REFERENCES cc1mg8.funcionario (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cc1mg8.atendimento ADD CONSTRAINT tipo_lixo_atendimento_fk
FOREIGN KEY (id_tipo_lixo)
REFERENCES cc1mg8.tipo_lixo (id_tipo_lixo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cc1mg8.atendimento ADD CONSTRAINT veiculo_atendimento_fk
FOREIGN KEY (id_veiculo)
REFERENCES cc1mg8.veiculo (id_veiculo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cc1mg8.endereco ADD CONSTRAINT cliente_endereco_fk
FOREIGN KEY (id_cliente)
REFERENCES cc1mg8.cliente (id_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cc1mg8.pedidos ADD CONSTRAINT endereco_pedidos_fk
FOREIGN KEY (id_endereco)
REFERENCES cc1mg8.endereco (id_endereco)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cc1mg8.atendimento ADD CONSTRAINT pedidos_atendimento_fk
FOREIGN KEY (id_pedido)
REFERENCES cc1mg8.pedidos (id_pedido)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;