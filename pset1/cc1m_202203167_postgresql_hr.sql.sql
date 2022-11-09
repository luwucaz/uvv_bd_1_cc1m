CREATE DATABASE uvv;

CREATE SCHEMA hr;

CREATE USER lucas;
ALTER SCHEMA hr OWNER TO lucas;

--
--  CARGOS
--

CREATE TABLE hr.cargos (
    id_cargo character varying(10) NOT NULL,
    cargo character varying(35) NOT NULL,
    salario_minimo numeric(8,2),
    salario_maximo numeric(8,2)
);

ALTER TABLE hr.cargos OWNER TO lucas;

COMMENT ON TABLE hr.cargos IS 'Tabela de cargos, contem os cargos existentes, e seu salário minímo e máximo mensal.';

COMMENT ON COLUMN hr.cargos.id_cargo IS 'Chave primária da tabela cargos.
Se relaciona com a tabela histórico de cargos.
Se relaciona com a tabela empregados.';

COMMENT ON COLUMN hr.cargos.salario_minimo IS 'Valor do salário mensal mínimo reconhecido para o cargo.
Obrigatoriamnte menos que o salário máximo';

COMMENT ON COLUMN hr.cargos.salario_maximo IS 'Valor do salário mensal máximo reconhecido para o cargo.
Obrigatoriamnte maior que o salário mínimo.';

--
--  DEPARTAMENTOS
--

CREATE TABLE hr.departamentos (
    id_departamento integer NOT NULL,
    nome character varying(50),
    id_localizacao integer NOT NULL,
    id_gerente integer
);

ALTER TABLE hr.departamentos OWNER TO lucas;

COMMENT ON TABLE hr.departamentos IS 'Tabela de departamentos, contém os dados do departamento da firma ou empresa.';

COMMENT ON COLUMN hr.departamentos.nome IS 'Nome dos departamentos da tabela departamentos.
Chave alternativa da tabela departamentos.';

COMMENT ON COLUMN hr.departamentos.id_localizacao IS 'Chave estrangeira da tabela localizações.';

COMMENT ON COLUMN hr.departamentos.id_gerente IS 'Chave estrangeira da tabela empregados.
Caso exista um empregado que seja gerente, este é seu ID';

--
--  EMPREGADOS
--

CREATE TABLE hr.empregados (
    id_empregado integer NOT NULL,
    nome character varying(75) NOT NULL,
    email character varying(35) NOT NULL,
    telefone character varying(20),
    data_contratacao date NOT NULL,
    id_cargo character varying(10) NOT NULL,
    salario numeric,
    comissao numeric(4,2),
    id_departamento integer,
    id_supervisor integer
);


ALTER TABLE hr.empregados OWNER TO lucas;

COMMENT ON COLUMN hr.empregados.id_empregado IS 'Chave primária da tabela empregados.
Se relaciona com a tabela departamentos.
Se relaciona com a tabela histórico de cargos (sendo uma parte de sua chave primária).';

COMMENT ON COLUMN hr.empregados.nome IS 'Nome completo do empregado.';

COMMENT ON COLUMN hr.empregados.email IS 'E-mail do empregado.
Sem caractere especial (@, !, ", '', +, ...)';

COMMENT ON COLUMN hr.empregados.telefone IS 'Telefone do empregado.
Admitido adicionar o código do país e DDD).
Sem caractere especial (@, !, ", '', +, ...).';

COMMENT ON COLUMN hr.empregados.data_contratacao IS 'Data de contratação do funcionário da tabela empregados.';

COMMENT ON COLUMN hr.empregados.id_cargo IS 'Chave estrangeira da tabela cargos.';

COMMENT ON COLUMN hr.empregados.salario IS 'Valor do salário mensal do empregado.';

COMMENT ON COLUMN hr.empregados.comissao IS 'Porcentagem (em decimal) da comissão de um empregado.
Admitido departamento de vendas apenas.';

COMMENT ON COLUMN hr.empregados.id_departamento IS 'Chave estrangeira da tabela departamentos.';

COMMENT ON COLUMN hr.empregados.id_supervisor IS 'Chave de autorelacionamento da tabela empregados. Indica o supervisor direto do empregado.';

--
--  HISTORICO CARGOS
--

CREATE TABLE hr.historico_cargos (
    id_empregado integer NOT NULL,
    data_inicial date NOT NULL,
    data_final date NOT NULL,
    id_cargo character varying NOT NULL,
    id_departamento integer
);

ALTER TABLE hr.historico_cargos OWNER TO lucas;

COMMENT ON TABLE hr.historico_cargos IS 'Tabela de histórico de cargos, contém o histórico de cargos de um determinado empregado. Mudanças de departamento ou cargos devem ser inseridas em novas linhas.';

COMMENT ON COLUMN hr.historico_cargos.data_inicial IS 'Parte da chave primária da tabela histórico de cargos.
Obrigatoriamente menor que a data final.';

COMMENT ON COLUMN hr.historico_cargos.data_final IS 'Data final do empregado no cargo. Obrigatoriamente maior que a data inicial.';

COMMENT ON COLUMN hr.historico_cargos.id_cargo IS 'Chave estrangeira da tabela cargos.';

COMMENT ON COLUMN hr.historico_cargos.id_departamento IS 'Chave estrangeira da tabela departamentos.';

--
--  LOCALIZACOES
--

CREATE TABLE hr.localizacoes (
    id_localizacao integer NOT NULL,
    endereco character varying(50),
    cep character(20),
    cidade character varying(50),
    uf character varying(50),
    id_pais character(2)
);

ALTER TABLE hr.localizacoes OWNER TO lucas;

COMMENT ON TABLE hr.localizacoes IS 'Chave primária da tabela regiões.
Se relaciona com a tabela departamentos.';

COMMENT ON COLUMN hr.localizacoes.id_localizacao IS 'Chave primária da tabela regiões.
Se relaciona com a tabela departamentos.';

COMMENT ON COLUMN hr.localizacoes.endereco IS 'Endereço da firma ou escritória da empresa.
Inserir: Rua (ou) Avenidade (ou) Rodovia e número.';

COMMENT ON COLUMN hr.localizacoes.cep IS 'CEP da firma ou escritória da empresa.
Apenas números, sem caractéres especiais ou símbolos.';

COMMENT ON COLUMN hr.localizacoes.cidade IS 'Cidade (em extenso) da firma ou escritória da empresa.';

COMMENT ON COLUMN hr.localizacoes.uf IS 'Estado (em abreviatura) da firma ou escritória da empresa.';

COMMENT ON COLUMN hr.localizacoes.id_pais IS 'Chave estrangeira da tabela países.';

--
--  PAISES
--

CREATE TABLE hr.paises (
    id_pais character(2) NOT NULL,
    nome character varying(50) NOT NULL,
    id_regiao integer
);

ALTER TABLE hr.paises OWNER TO lucas;

COMMENT ON TABLE hr.paises IS 'Tabela de países, contém as informações dos países, com seu nome e ID.';

COMMENT ON COLUMN hr.paises.id_pais IS 'Chave primária da tabela países.
Se relaciona com a tabela localizações.';

COMMENT ON COLUMN hr.paises.nome IS 'Nome dos paises da tabela países.';

--
--  REGIOES
--

CREATE TABLE hr.regioes (
    id_regiao integer NOT NULL,
    nome character varying(25) NOT NULL
);

ALTER TABLE hr.regioes OWNER TO postgres;

COMMENT ON TABLE hr.regioes IS 'Tabela de regiões, contém nome da região e seu ID.';

COMMENT ON COLUMN hr.regioes.id_regiao IS 'Chave primária da tabela regiões.';

COMMENT ON COLUMN hr.regioes.nome IS 'Nome das regiões da tabela regiões.';

--
--  INSERÇÃO DE DADOS
--

INSERT INTO hr.cargos VALUES ('AD_PRES', 'President', 20080.00, 40000.00);
INSERT INTO hr.cargos VALUES ('AD_VP', 'Administration Vice President', 15000.00, 30000.00);
INSERT INTO hr.cargos VALUES ('AD_ASST', 'Administration Assistant', 3000.00, 6000.00);
INSERT INTO hr.cargos VALUES ('FI_MGR', 'Finance Manager', 8200.00, 16000.00);
INSERT INTO hr.cargos VALUES ('FI_ACCOUNT', 'Accountant', 4200.00, 9000.00);
INSERT INTO hr.cargos VALUES ('AC_MGR', 'Accounting Manager', 8200.00, 16000.00);
INSERT INTO hr.cargos VALUES ('AC_ACCOUNT', 'Public Accountant', 4200.00, 9000.00);
INSERT INTO hr.cargos VALUES ('SA_MAN', 'Sales Manager', 10000.00, 20080.00);
INSERT INTO hr.cargos VALUES ('SA_REP', 'Sales Representative', 6000.00, 12008.00);
INSERT INTO hr.cargos VALUES ('PU_MAN', 'Purchasing Manager', 8000.00, 15000.00);
INSERT INTO hr.cargos VALUES ('PU_CLERK', 'Purchasing Clerk', 2500.00, 5500.00);
INSERT INTO hr.cargos VALUES ('ST_MAN', 'Stock Manager', 5500.00, 8500.00);
INSERT INTO hr.cargos VALUES ('ST_CLERK', 'Stock Clerk', 2008.00, 5000.00);
INSERT INTO hr.cargos VALUES ('SH_CLERK', 'Shipping Clerk', 2500.00, 5500.00);
INSERT INTO hr.cargos VALUES ('IT_PROG', 'Programmer', 4000.00, 10000.00);
INSERT INTO hr.cargos VALUES ('MK_MAN', 'Marketing Manager', 9000.00, 15000.00);
INSERT INTO hr.cargos VALUES ('MK_REP', 'Marketing Representative', 4000.00, 9000.00);
INSERT INTO hr.cargos VALUES ('HR_REP', 'Human Resources Representative', 4000.00, 9000.00);
INSERT INTO hr.cargos VALUES ('PR_REP', 'Public Relations Representative', 4500.00, 10500.00);



INSERT INTO hr.departamentos VALUES (10, 'Administration', 1700, 200);
INSERT INTO hr.departamentos VALUES (20, 'Marketing', 1800, 201);
INSERT INTO hr.departamentos VALUES (30, 'Purchasing', 1700, 114);
INSERT INTO hr.departamentos VALUES (40, 'Human Resources', 2400, 203);
INSERT INTO hr.departamentos VALUES (50, 'Shipping', 1500, 121);
INSERT INTO hr.departamentos VALUES (60, 'IT', 1400, 103);
INSERT INTO hr.departamentos VALUES (70, 'Public Relations', 2700, 204);
INSERT INTO hr.departamentos VALUES (80, 'Sales', 2500, 145);
INSERT INTO hr.departamentos VALUES (90, 'Executive', 1700, 100);
INSERT INTO hr.departamentos VALUES (100, 'Finance', 1700, 108);
INSERT INTO hr.departamentos VALUES (110, 'Accounting', 1700, 205);
INSERT INTO hr.departamentos VALUES (120, 'Treasury', 1700, NULL);
INSERT INTO hr.departamentos VALUES (130, 'Corporate Tax', 1700, NULL);
INSERT INTO hr.departamentos VALUES (140, 'Control And Credit', 1700, NULL);
INSERT INTO hr.departamentos VALUES (150, 'Shareholder Services', 1700, NULL);
INSERT INTO hr.departamentos VALUES (160, 'Benefits', 1700, NULL);
INSERT INTO hr.departamentos VALUES (170, 'Manufacturing', 1700, NULL);
INSERT INTO hr.departamentos VALUES (180, 'Construction', 1700, NULL);
INSERT INTO hr.departamentos VALUES (190, 'Contracting', 1700, NULL);
INSERT INTO hr.departamentos VALUES (200, 'Operations', 1700, NULL);
INSERT INTO hr.departamentos VALUES (210, 'IT Support', 1700, NULL);
INSERT INTO hr.departamentos VALUES (220, 'NOC', 1700, NULL);
INSERT INTO hr.departamentos VALUES (230, 'IT Helpdesk', 1700, NULL);
INSERT INTO hr.departamentos VALUES (240, 'Government Sales', 1700, NULL);
INSERT INTO hr.departamentos VALUES (250, 'Retail Sales', 1700, NULL);
INSERT INTO hr.departamentos VALUES (260, 'Recruiting', 1700, NULL);
INSERT INTO hr.departamentos VALUES (270, 'Payroll', 1700, NULL);



INSERT INTO hr.empregados VALUES (198, 'Donald OConnell', 'DOCONNEL', '650.507.9833', '2007-06-21', 'SH_CLERK', 2600, NULL, 50, 124);
INSERT INTO hr.empregados VALUES (199, 'Douglas Grant', 'DGRANT', '650.507.9844', '2008-01-13', 'SH_CLERK', 2600, NULL, 50, 124);
INSERT INTO hr.empregados VALUES (200, 'Jennifer Whalen', 'JWHALEN', '515.123.4444', '2003-09-17', 'AD_ASST', 4400, NULL, 10, 101);
INSERT INTO hr.empregados VALUES (201, 'Michael Hartstein', 'MHARTSTE', '515.123.5555', '2004-02-17', 'MK_MAN', 13000, NULL, 20, 100);
INSERT INTO hr.empregados VALUES (202, 'Pat Fay', 'PFAY', '603.123.6666', '2005-08-17', 'MK_REP', 6000, NULL, 20, 201);
INSERT INTO hr.empregados VALUES (203, 'Susan Mavris', 'SMAVRIS', '515.123.7777', '2002-06-07', 'HR_REP', 6500, NULL, 40, 101);
INSERT INTO hr.empregados VALUES (204, 'Hermann Baer', 'HBAER', '515.123.8888', '2002-06-07', 'PR_REP', 10000, NULL, 70, 101);
INSERT INTO hr.empregados VALUES (205, 'Shelley Higgins', 'SHIGGINS', '515.123.8080', '2002-06-07', 'AC_MGR', 12008, NULL, 110, 101);
INSERT INTO hr.empregados VALUES (206, 'William Gietz', 'WGIETZ', '515.123.8181', '2002-06-07', 'AC_ACCOUNT', 8300, NULL, 110, 205);
INSERT INTO hr.empregados VALUES (100, 'Steven King', 'SKING', '515.123.4567', '2003-06-17', 'AD_PRES', 24000, NULL, 90, NULL);
INSERT INTO hr.empregados VALUES (101, 'Neena Kochhar', 'NKOCHHAR', '515.123.4568', '2005-09-21', 'AD_VP', 17000, NULL, 90, 100);
INSERT INTO hr.empregados VALUES (102, 'Lex De Haan', 'LDEHAAN', '515.123.4569', '2001-01-13', 'AD_VP', 17000, NULL, 90, 100);
INSERT INTO hr.empregados VALUES (103, 'Alexander Hunold', 'AHUNOLD', '590.423.4567', '2006-01-03', 'IT_PROG', 9000, NULL, 60, 102);
INSERT INTO hr.empregados VALUES (104, 'Bruce Ernst', 'BERNST', '590.423.4568', '2007-05-21', 'IT_PROG', 6000, NULL, 60, 103);
INSERT INTO hr.empregados VALUES (105, 'David Austin', 'DAUSTIN', '590.423.4569', '2005-06-25', 'IT_PROG', 4800, NULL, 60, 103);
INSERT INTO hr.empregados VALUES (106, 'Valli Pataballa', 'VPATABAL', '590.423.4560', '2006-02-05', 'IT_PROG', 4800, NULL, 60, 103);
INSERT INTO hr.empregados VALUES (107, 'Diana Lorentz', 'DLORENTZ', '590.423.5567', '2007-02-07', 'IT_PROG', 4200, NULL, 60, 103);
INSERT INTO hr.empregados VALUES (108, 'Nancy Greenberg', 'NGREENBE', '515.124.4569', '2002-08-17', 'FI_MGR', 12008, NULL, 100, 101);
INSERT INTO hr.empregados VALUES (109, 'Daniel Faviet', 'DFAVIET', '515.124.4169', '2002-08-16', 'FI_ACCOUNT', 9000, NULL, 100, 108);
INSERT INTO hr.empregados VALUES (110, 'John Chen', 'JCHEN', '515.124.4269', '2005-09-28', 'FI_ACCOUNT', 8200, NULL, 100, 108);
INSERT INTO hr.empregados VALUES (111, 'Ismael Sciarra', 'ISCIARRA', '515.124.4369', '2005-09-30', 'FI_ACCOUNT', 7700, NULL, 100, 108);
INSERT INTO hr.empregados VALUES (112, 'Jose Manuel Urman', 'JMURMAN', '515.124.4469', '2006-03-07', 'FI_ACCOUNT', 7800, NULL, 100, 108);
INSERT INTO hr.empregados VALUES (113, 'Luis Popp', 'LPOPP', '515.124.4567', '2007-12-07', 'FI_ACCOUNT', 6900, NULL, 100, 108);
INSERT INTO hr.empregados VALUES (114, 'Den Raphaely', 'DRAPHEAL', '515.127.4561', '2002-12-07', 'PU_MAN', 11000, NULL, 30, 100);
INSERT INTO hr.empregados VALUES (115, 'Alexander Khoo', 'AKHOO', '515.127.4562', '2003-05-18', 'PU_CLERK', 3100, NULL, 30, 114);
INSERT INTO hr.empregados VALUES (116, 'Shelli Baida', 'SBAIDA', '515.127.4563', '2005-12-24', 'PU_CLERK', 2900, NULL, 30, 114);
INSERT INTO hr.empregados VALUES (117, 'Sigal Tobias', 'STOBIAS', '515.127.4564', '2005-07-24', 'PU_CLERK', 2800, NULL, 30, 114);
INSERT INTO hr.empregados VALUES (118, 'Guy Himuro', 'GHIMURO', '515.127.4565', '2006-11-15', 'PU_CLERK', 2600, NULL, 30, 114);
INSERT INTO hr.empregados VALUES (119, 'Karen Colmenares', 'KCOLMENA', '515.127.4566', '2007-08-10', 'PU_CLERK', 2500, NULL, 30, 114);
INSERT INTO hr.empregados VALUES (120, 'Matthew Weiss', 'MWEISS', '650.123.1234', '2004-07-18', 'ST_MAN', 8000, NULL, 50, 100);
INSERT INTO hr.empregados VALUES (121, 'Adam Fripp', 'AFRIPP', '650.123.2234', '2005-04-10', 'ST_MAN', 8200, NULL, 50, 100);
INSERT INTO hr.empregados VALUES (122, 'Payam Kaufling', 'PKAUFLIN', '650.123.3234', '2003-05-01', 'ST_MAN', 7900, NULL, 50, 100);
INSERT INTO hr.empregados VALUES (123, 'Shanta Vollman', 'SVOLLMAN', '650.123.4234', '2005-10-10', 'ST_MAN', 6500, NULL, 50, 100);
INSERT INTO hr.empregados VALUES (124, 'Kevin Mourgos', 'KMOURGOS', '650.123.5234', '2007-11-16', 'ST_MAN', 5800, NULL, 50, 100);
INSERT INTO hr.empregados VALUES (125, 'Julia Nayer', 'JNAYER', '650.124.1214', '2005-07-16', 'ST_CLERK', 3200, NULL, 50, 120);
INSERT INTO hr.empregados VALUES (126, 'Irene Mikkilineni', 'IMIKKILI', '650.124.1224', '2006-09-28', 'ST_CLERK', 2700, NULL, 50, 120);
INSERT INTO hr.empregados VALUES (127, 'James Landry', 'JLANDRY', '650.124.1334', '2007-01-14', 'ST_CLERK', 2400, NULL, 50, 120);
INSERT INTO hr.empregados VALUES (128, 'Steven Markle', 'SMARKLE', '650.124.1434', '2008-03-08', 'ST_CLERK', 2200, NULL, 50, 120);
INSERT INTO hr.empregados VALUES (129, 'Laura Bissot', 'LBISSOT', '650.124.5234', '2005-08-20', 'ST_CLERK', 3300, NULL, 50, 121);
INSERT INTO hr.empregados VALUES (130, 'Mozhe Atkinson', 'MATKINSO', '650.124.6234', '2005-10-30', 'ST_CLERK', 2800, NULL, 50, 121);
INSERT INTO hr.empregados VALUES (131, 'James Marlow', 'JAMRLOW', '650.124.7234', '2005-02-16', 'ST_CLERK', 2500, NULL, 50, 121);
INSERT INTO hr.empregados VALUES (132, 'TJ Olson', 'TJOLSON', '650.124.8234', '2007-04-10', 'ST_CLERK', 2100, NULL, 50, 121);
INSERT INTO hr.empregados VALUES (133, 'Jason Mallin', 'JMALLIN', '650.127.1934', '2004-06-14', 'ST_CLERK', 3300, NULL, 50, 122);
INSERT INTO hr.empregados VALUES (134, 'Michael Rogers', 'MROGERS', '650.127.1834', '2006-08-26', 'ST_CLERK', 2900, NULL, 50, 122);
INSERT INTO hr.empregados VALUES (135, 'Ki Gee', 'KGEE', '650.127.1734', '2007-12-12', 'ST_CLERK', 2400, NULL, 50, 122);
INSERT INTO hr.empregados VALUES (136, 'Hazel Philtanker', 'HPHILTAN', '650.127.1634', '2008-02-06', 'ST_CLERK', 2200, NULL, 50, 122);
INSERT INTO hr.empregados VALUES (137, 'Renske Ladwig', 'RLADWIG', '650.121.1234', '2003-07-14', 'ST_CLERK', 3600, NULL, 50, 123);
INSERT INTO hr.empregados VALUES (138, 'Stephen Stiles', 'SSTILES', '650.121.2034', '2005-10-26', 'ST_CLERK', 3200, NULL, 50, 123);
INSERT INTO hr.empregados VALUES (139, 'John Seo', 'JSEO', '650.121.2019', '2006-02-12', 'ST_CLERK', 2700, NULL, 50, 123);
INSERT INTO hr.empregados VALUES (140, 'Joshua Patel', 'JPATEL', '650.121.1834', '2006-04-06', 'ST_CLERK', 2500, NULL, 50, 123);
INSERT INTO hr.empregados VALUES (141, 'Trenna Rajs', 'TRAJS', '650.121.8009', '2003-10-17', 'ST_CLERK', 3500, NULL, 50, 124);
INSERT INTO hr.empregados VALUES (142, 'Curtis Davies', 'CDAVIES', '650.121.2994', '2005-01-29', 'ST_CLERK', 3100, NULL, 50, 124);
INSERT INTO hr.empregados VALUES (143, 'Randall Matos', 'RMATOS', '650.121.2874', '2006-03-15', 'ST_CLERK', 2600, NULL, 50, 124);
INSERT INTO hr.empregados VALUES (144, 'Peter Vargas', 'PVARGAS', '650.121.2004', '2006-07-09', 'ST_CLERK', 2500, NULL, 50, 124);
INSERT INTO hr.empregados VALUES (180, 'Winston Taylor', 'WTAYLOR', '650.507.9876', '2006-01-24', 'SH_CLERK', 3200, NULL, 50, 120);
INSERT INTO hr.empregados VALUES (181, 'Jean Fleaur', 'JFLEAUR', '650.507.9877', '2006-02-23', 'SH_CLERK', 3100, NULL, 50, 120);
INSERT INTO hr.empregados VALUES (182, 'Martha Sullivan', 'MSULLIVA', '650.507.9878', '2007-06-21', 'SH_CLERK', 2500, NULL, 50, 120);
INSERT INTO hr.empregados VALUES (183, 'Girard Geoni', 'GGEONI', '650.507.9879', '2008-02-03', 'SH_CLERK', 2800, NULL, 50, 120);
INSERT INTO hr.empregados VALUES (184, 'Nandita Sarchand', 'NSARCHAN', '650.509.1876', '2004-01-27', 'SH_CLERK', 4200, NULL, 50, 121);
INSERT INTO hr.empregados VALUES (185, 'Alexis Bull', 'ABULL', '650.509.2876', '2005-02-20', 'SH_CLERK', 4100, NULL, 50, 121);
INSERT INTO hr.empregados VALUES (186, 'Julia Dellinger', 'JDELLING', '650.509.3876', '2006-06-24', 'SH_CLERK', 3400, NULL, 50, 121);
INSERT INTO hr.empregados VALUES (187, 'Anthony Cabrio', 'ACABRIO', '650.509.4876', '2007-02-07', 'SH_CLERK', 3000, NULL, 50, 121);
INSERT INTO hr.empregados VALUES (188, 'Kelly Chung', 'KCHUNG', '650.505.1876', '2005-06-14', 'SH_CLERK', 3800, NULL, 50, 122);
INSERT INTO hr.empregados VALUES (189, 'Jennifer Dilly', 'JDILLY', '650.505.2876', '2005-08-13', 'SH_CLERK', 3600, NULL, 50, 122);
INSERT INTO hr.empregados VALUES (190, 'Timothy Gates', 'TGATES', '650.505.3876', '2006-07-11', 'SH_CLERK', 2900, NULL, 50, 122);
INSERT INTO hr.empregados VALUES (191, 'Randall Perkins', 'RPERKINS', '650.505.4876', '2007-12-19', 'SH_CLERK', 2500, NULL, 50, 122);
INSERT INTO hr.empregados VALUES (192, 'Sarah Bell', 'SBELL', '650.501.1876', '2004-02-04', 'SH_CLERK', 4000, NULL, 50, 123);
INSERT INTO hr.empregados VALUES (193, 'Britney Everett', 'BEVERETT', '650.501.2876', '2005-03-03', 'SH_CLERK', 3900, NULL, 50, 123);
INSERT INTO hr.empregados VALUES (194, 'Samuel McCain', 'SMCCAIN', '650.501.3876', '2006-07-01', 'SH_CLERK', 3200, NULL, 50, 123);
INSERT INTO hr.empregados VALUES (195, 'Vance Jones', 'VJONES', '650.501.4876', '2007-03-17', 'SH_CLERK', 2800, NULL, 50, 123);
INSERT INTO hr.empregados VALUES (196, 'Alana Walsh', 'AWALSH', '650.507.9811', '2006-04-24', 'SH_CLERK', 3100, NULL, 50, 124);
INSERT INTO hr.empregados VALUES (197, 'Kevin Feeney', 'KFEENEY', '650.507.9822', '2006-05-23', 'SH_CLERK', 3000, NULL, 50, 124);
INSERT INTO hr.empregados VALUES (145, 'John Russell', 'JRUSSEL', '011.44.1344.429268', '2004-10-01', 'SA_MAN', 14000, 0.40, 80, 100);
INSERT INTO hr.empregados VALUES (146, 'Karen Partners', 'KPARTNER', '011.44.1344.467268', '2005-01-05', 'SA_MAN', 13500, 0.30, 80, 100);
INSERT INTO hr.empregados VALUES (147, 'Alberto Errazuriz', 'AERRAZUR', '011.44.1344.429278', '2005-03-10', 'SA_MAN', 12000, 0.30, 80, 100);
INSERT INTO hr.empregados VALUES (148, 'Gerald Cambrault', 'GCAMBRAU', '011.44.1344.619268', '2007-10-15', 'SA_MAN', 11000, 0.30, 80, 100);
INSERT INTO hr.empregados VALUES (149, 'Eleni Zlotkey', 'EZLOTKEY', '011.44.1344.429018', '2008-01-29', 'SA_MAN', 10500, 0.20, 80, 100);
INSERT INTO hr.empregados VALUES (150, 'Peter Tucker', 'PTUCKER', '011.44.1344.129268', '2005-01-30', 'SA_REP', 10000, 0.30, 80, 145);
INSERT INTO hr.empregados VALUES (151, 'David Bernstein', 'DBERNSTE', '011.44.1344.345268', '2005-03-24', 'SA_REP', 9500, 0.25, 80, 145);
INSERT INTO hr.empregados VALUES (152, 'Peter Hall', 'PHALL', '011.44.1344.478968', '2005-08-20', 'SA_REP', 9000, 0.25, 80, 145);
INSERT INTO hr.empregados VALUES (153, 'Christopher Olsen', 'COLSEN', '011.44.1344.498718', '2006-03-30', 'SA_REP', 8000, 0.20, 80, 145);
INSERT INTO hr.empregados VALUES (154, 'Nanette Cambrault', 'NCAMBRAU', '011.44.1344.987668', '2006-12-09', 'SA_REP', 7500, 0.20, 80, 145);
INSERT INTO hr.empregados VALUES (155, 'Oliver Tuvault', 'OTUVAULT', '011.44.1344.486508', '2007-11-23', 'SA_REP', 7000, 0.15, 80, 145);
INSERT INTO hr.empregados VALUES (156, 'Janette King', 'JKING', '011.44.1345.429268', '2004-01-30', 'SA_REP', 10000, 0.35, 80, 146);
INSERT INTO hr.empregados VALUES (157, 'Patrick Sully', 'PSULLY', '011.44.1345.929268', '2004-03-04', 'SA_REP', 9500, 0.35, 80, 146);
INSERT INTO hr.empregados VALUES (158, 'Allan McEwen', 'AMCEWEN', '011.44.1345.829268', '2004-08-01', 'SA_REP', 9000, 0.35, 80, 146);
INSERT INTO hr.empregados VALUES (159, 'Lindsey Smith', 'LSMITH', '011.44.1345.729268', '2005-03-10', 'SA_REP', 8000, 0.30, 80, 146);
INSERT INTO hr.empregados VALUES (160, 'Louise Doran', 'LDORAN', '011.44.1345.629268', '2005-12-15', 'SA_REP', 7500, 0.30, 80, 146);
INSERT INTO hr.empregados VALUES (161, 'Sarath Sewall', 'SSEWALL', '011.44.1345.529268', '2006-11-03', 'SA_REP', 7000, 0.25, 80, 146);
INSERT INTO hr.empregados VALUES (162, 'Clara Vishney', 'CVISHNEY', '011.44.1346.129268', '2005-11-11', 'SA_REP', 10500, 0.25, 80, 147);
INSERT INTO hr.empregados VALUES (163, 'Danielle Greene', 'DGREENE', '011.44.1346.229268', '2007-03-19', 'SA_REP', 9500, 0.15, 80, 147);
INSERT INTO hr.empregados VALUES (164, 'Mattea Marvins', 'MMARVINS', '011.44.1346.329268', '2008-01-24', 'SA_REP', 7200, 0.10, 80, 147);
INSERT INTO hr.empregados VALUES (165, 'David Lee', 'DLEE', '011.44.1346.529268', '2008-02-23', 'SA_REP', 6800, 0.10, 80, 147);
INSERT INTO hr.empregados VALUES (166, 'Sundar Ande', 'SANDE', '011.44.1346.629268', '2008-03-24', 'SA_REP', 6400, 0.10, 80, 147);
INSERT INTO hr.empregados VALUES (167, 'Amit Banda', 'ABANDA', '011.44.1346.729268', '2008-04-21', 'SA_REP', 6200, 0.10, 80, 147);
INSERT INTO hr.empregados VALUES (168, 'Lisa Ozer', 'LOZER', '011.44.1343.929268', '2005-03-11', 'SA_REP', 11500, 0.25, 80, 148);
INSERT INTO hr.empregados VALUES (169, 'Harrison Bloom', 'HBLOOM', '011.44.1343.829268', '2006-03-23', 'SA_REP', 10000, 0.20, 80, 148);
INSERT INTO hr.empregados VALUES (170, 'Tayler Fox', 'TFOX', '011.44.1343.729268', '2006-01-24', 'SA_REP', 9600, 0.20, 80, 148);
INSERT INTO hr.empregados VALUES (171, 'William Smith', 'WSMITH', '011.44.1343.629268', '2007-02-23', 'SA_REP', 7400, 0.15, 80, 148);
INSERT INTO hr.empregados VALUES (172, 'Elizabeth Bates', 'EBATES', '011.44.1343.529268', '2007-03-24', 'SA_REP', 7300, 0.15, 80, 148);
INSERT INTO hr.empregados VALUES (173, 'Sundita Kumar', 'SKUMAR', '011.44.1343.329268', '2008-04-21', 'SA_REP', 6100, 0.10, 80, 148);
INSERT INTO hr.empregados VALUES (174, 'Ellen Abel', 'EABEL', '011.44.1644.429267', '2004-05-11', 'SA_REP', 11000, 0.30, 80, 149);
INSERT INTO hr.empregados VALUES (175, 'Alyssa Hutton', 'AHUTTON', '011.44.1644.429266', '2005-03-19', 'SA_REP', 8800, 0.25, 80, 149);
INSERT INTO hr.empregados VALUES (176, 'Jonathon Taylor', 'JTAYLOR', '011.44.1644.429265', '2006-03-24', 'SA_REP', 8600, 0.20, 80, 149);
INSERT INTO hr.empregados VALUES (177, 'Jack Livingston', 'JLIVINGS', '011.44.1644.429264', '2006-04-23', 'SA_REP', 8400, 0.20, 80, 149);
INSERT INTO hr.empregados VALUES (178, 'Kimberely Grant', 'KGRANT', '011.44.1644.429263', '2007-05-24', 'SA_REP', 7000, 0.15, NULL, 149);
INSERT INTO hr.empregados VALUES (179, 'Charles Johnson', 'CJOHNSON', '011.44.1644.429262', '2008-01-04', 'SA_REP', 6200, 0.10, 80, 149);



INSERT INTO hr.historico_cargos VALUES (102, '2001-01-13', '2006-07-24', 'IT_PROG', 60);
INSERT INTO hr.historico_cargos VALUES (101, '1997-09-21', '2001-10-27', 'AC_ACCOUNT', 110);
INSERT INTO hr.historico_cargos VALUES (101, '2001-10-28', '2005-03-15', 'AC_MGR', 110);
INSERT INTO hr.historico_cargos VALUES (201, '2004-02-17', '2007-12-19', 'MK_REP', 20);
INSERT INTO hr.historico_cargos VALUES (114, '2006-03-24', '2007-12-31', 'ST_CLERK', 50);
INSERT INTO hr.historico_cargos VALUES (122, '2007-01-01', '2007-12-31', 'ST_CLERK', 50);
INSERT INTO hr.historico_cargos VALUES (200, '1995-09-17', '2001-06-17', 'AD_ASST', 90);
INSERT INTO hr.historico_cargos VALUES (176, '2006-03-24', '2006-12-31', 'SA_REP', 80);
INSERT INTO hr.historico_cargos VALUES (176, '2007-01-01', '2007-12-31', 'SA_MAN', 80);
INSERT INTO hr.historico_cargos VALUES (200, '2002-07-01', '2006-12-31', 'AC_ACCOUNT', 90);



INSERT INTO hr.localizacoes VALUES (1000, '1297 Via Cola di Rie', '00989', 'Roma', NULL, 'IT');
INSERT INTO hr.localizacoes VALUES (1100, '93091 Calle della Testa', '10934', 'Venice', NULL, 'IT');
INSERT INTO hr.localizacoes VALUES (1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP');
INSERT INTO hr.localizacoes VALUES (1300, '9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 'JP');
INSERT INTO hr.localizacoes VALUES (1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');
INSERT INTO hr.localizacoes VALUES (1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US');
INSERT INTO hr.localizacoes VALUES (1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US');
INSERT INTO hr.localizacoes VALUES (1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US');
INSERT INTO hr.localizacoes VALUES (1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA');
INSERT INTO hr.localizacoes VALUES (1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA');
INSERT INTO hr.localizacoes VALUES (2000, '40-5-12 Laogianggen', '190518', 'Beijing', NULL, 'CN');
INSERT INTO hr.localizacoes VALUES (2100, '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN');
INSERT INTO hr.localizacoes VALUES (2200, '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU');
INSERT INTO hr.localizacoes VALUES (2300, '198 Clementi North', '540198', 'Singapore', NULL, 'SG');
INSERT INTO hr.localizacoes VALUES (2400, '8204 Arthur St', NULL, 'London', NULL, 'UK');
INSERT INTO hr.localizacoes VALUES (2500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB             ', 'Oxford', 'Oxford', 'UK');
INSERT INTO hr.localizacoes VALUES (2600, '9702 Chester Road', '09629850293', 'Stretford', 'Manchester', 'UK');
INSERT INTO hr.localizacoes VALUES (2700, 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE');
INSERT INTO hr.localizacoes VALUES (2800, 'Rua Frei Caneca 1360 ', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR');
INSERT INTO hr.localizacoes VALUES (2900, '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH');
INSERT INTO hr.localizacoes VALUES (3000, 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH');
INSERT INTO hr.localizacoes VALUES (3100, 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL');
INSERT INTO hr.localizacoes VALUES (3200, 'Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal,', 'MX');



INSERT INTO hr.paises VALUES ('BE', 'Belgium', 1);
INSERT INTO hr.paises VALUES ('IT', 'Italy', 1);
INSERT INTO hr.paises VALUES ('JP', 'Japan', 3);
INSERT INTO hr.paises VALUES ('US', 'United States of America', 2);
INSERT INTO hr.paises VALUES ('CA', 'Canada', 2);
INSERT INTO hr.paises VALUES ('CN', 'China', 3);
INSERT INTO hr.paises VALUES ('IN', 'India', 3);
INSERT INTO hr.paises VALUES ('AU', 'Australia', 3);
INSERT INTO hr.paises VALUES ('ZW', 'Zimbabwe', 4);
INSERT INTO hr.paises VALUES ('SG', 'Singapore', 3);
INSERT INTO hr.paises VALUES ('UK', 'United Kingdom', 1);
INSERT INTO hr.paises VALUES ('FR', 'France', 1);
INSERT INTO hr.paises VALUES ('DE', 'Germany', 1);
INSERT INTO hr.paises VALUES ('ZM', 'Zambia', 4);
INSERT INTO hr.paises VALUES ('EG', 'Egypt', 4);
INSERT INTO hr.paises VALUES ('BR', 'Brazil', 2);
INSERT INTO hr.paises VALUES ('CH', 'Switzerland', 1);
INSERT INTO hr.paises VALUES ('NL', 'Netherlands', 1);
INSERT INTO hr.paises VALUES ('MX', 'Mexico', 2);
INSERT INTO hr.paises VALUES ('KW', 'Kuwait', 4);
INSERT INTO hr.paises VALUES ('IL', 'Israel', 4);
INSERT INTO hr.paises VALUES ('DK', 'Denmark', 1);
INSERT INTO hr.paises VALUES ('ML', 'Malaysia', 3);
INSERT INTO hr.paises VALUES ('NG', 'Nigeria', 4);
INSERT INTO hr.paises VALUES ('AR', 'Argentina', 2);



INSERT INTO hr.regioes VALUES (4, 'Middle East and Africa');
INSERT INTO hr.regioes VALUES (1, 'Europe');
INSERT INTO hr.regioes VALUES (2, 'Americas');
INSERT INTO hr.regioes VALUES (3, 'Asia');

--
--  CHAVES PRIMARIAS E ESTRANGEIRAS
--

ALTER TABLE ONLY hr.cargos
    ADD CONSTRAINT cargos_pk PRIMARY KEY (id_cargo);

ALTER TABLE ONLY hr.departamentos
    ADD CONSTRAINT departamentos_pk PRIMARY KEY (id_departamento);

ALTER TABLE ONLY hr.empregados
    ADD CONSTRAINT empregados_pk PRIMARY KEY (id_empregado);

ALTER TABLE ONLY hr.historico_cargos
    ADD CONSTRAINT historico_cargos_pk PRIMARY KEY (id_empregado, data_inicial);

ALTER TABLE ONLY hr.localizacoes
    ADD CONSTRAINT localizacoes_pk PRIMARY KEY (id_localizacao);

ALTER TABLE ONLY hr.paises
    ADD CONSTRAINT paises_pk PRIMARY KEY (id_pais);

ALTER TABLE ONLY hr.regioes
    ADD CONSTRAINT regioes_pk PRIMARY KEY (id_regiao);

CREATE UNIQUE INDEX cargos_cargo_idx ON hr.cargos USING btree (cargo);

CREATE UNIQUE INDEX departamentos_nome_idx ON hr.departamentos USING btree (nome);

CREATE UNIQUE INDEX empregados_email_idx ON hr.empregados USING btree (email);

ALTER TABLE ONLY hr.departamentos
    ADD CONSTRAINT departamentos__localizacoes_fk FOREIGN KEY (id_localizacao) REFERENCES hr.localizacoes(id_localizacao);

ALTER TABLE ONLY hr.departamentos
    ADD CONSTRAINT departamentos_fk FOREIGN KEY (id_gerente) REFERENCES hr.empregados(id_empregado);

ALTER TABLE ONLY hr.empregados
    ADD CONSTRAINT empregados_cargos_fk FOREIGN KEY (id_cargo) REFERENCES hr.cargos(id_cargo);

ALTER TABLE ONLY hr.empregados
    ADD CONSTRAINT empregados_fk FOREIGN KEY (id_departamento) REFERENCES hr.departamentos(id_departamento);

ALTER TABLE ONLY hr.empregados
    ADD CONSTRAINT empregados_supervisor_fk FOREIGN KEY (id_supervisor) REFERENCES a.empregados(id_empregado);

ALTER TABLE ONLY hr.historico_cargos
    ADD CONSTRAINT historico_cargos_cargos_fk FOREIGN KEY (id_cargo) REFERENCES hr.cargos(id_cargo);

ALTER TABLE ONLY hr.historico_cargos
    ADD CONSTRAINT historico_cargos_empregados_fk FOREIGN KEY (id_empregado) REFERENCES hr.empregados(id_empregado);

ALTER TABLE ONLY hr.historico_cargos
    ADD CONSTRAINT historico_cargos_fk FOREIGN KEY (id_departamento) REFERENCES hr.departamentos(id_departamento);

ALTER TABLE ONLY hr.localizacoes
    ADD CONSTRAINT localizacoes_fk FOREIGN KEY (id_pais) REFERENCES hr.paises(id_pais);

ALTER TABLE ONLY hr.paises
    ADD CONSTRAINT paises_fk FOREIGN KEY (id_regiao) REFERENCES hr.regioes(id_regiao);



