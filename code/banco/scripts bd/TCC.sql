CREATE DATABASE driveZ;
USE driveZ;

CREATE TABLE tbl_cliente (
id_cliente int primary key auto_increment,
nome varchar(100) not null,
email varchar(100) not null,
telefone varchar(14) null,
img_perfil blob null,
cpf varchar(11)  null unique,
cnpj varchar(14)  null unique,
senha varchar(100) not null
);

CREATE TABLE tbl_prestador (
id_prestador int primary key auto_increment,
nome varchar(100) not null,
email varchar(100) not null,
telefone varchar(14) null,
img_perfil blob null,
cpf varchar(11) null unique,
cnh varchar(12) null unique,
cnpj varchar(14) null unique,
senha varchar(100) not null,
categoria VARCHAR(150) null,
descricao VARCHAR(300) null
);

CREATE TABLE tbl_veiculo(
id_veiculo int primary key auto_increment,
categoria varchar(100),
validade date not null,
codigo_renavam varchar(15) not null unique,
placa varchar(7) not null unique
);

CREATE TABLE tbl_servicos(
id_servicos int primary key auto_increment,
nome_servico varchar(100) not null,
descricao_servico varchar(150) not null,
img_icone blob null
);

CREATE TABLE tbl_endereco(
id_endereco int primary key auto_increment,
cep varchar(8) not null,
uf varchar(2) not null,
cidade varchar(200) not null,
logradouro varchar(200) not null,
bairro varchar(200) not null
);

CREATE TABLE tbl_pedido(
id_pedido int primary key auto_increment,
data_solicitacao datetime not null,
endereco_destino varchar(200) not null,
endereco_origem varchar(200) not null,
descricao varchar(150) not null,
distancia_km decimal(10,3) not null,
id_cliente int not null,
id_prestador int not null,
FOREIGN KEY (id_cliente) REFERENCES tbl_cliente (id_cliente),
FOREIGN KEY (id_prestador) REFERENCES tbl_prestador (id_prestador)
);

CREATE TABLE tbl_status(
id_status int primary key auto_increment,
status varchar(100) not null,
id_pedido int not null,
FOREIGN KEY (id_pedido) REFERENCES tbl_pedido (id_pedido)
);

CREATE TABLE tbl_avaliacao(
id_avaliacao int primary key auto_increment,
nota decimal(3,1) null,
comentario varchar(150) null,
id_pedido int not null,
FOREIGN KEY (id_pedido) REFERENCES tbl_pedido (id_pedido)
);

CREATE TABLE tbl_mensagem(
id_mensagem int primary key auto_increment,
data_envio datetime not null,
texto_mensagem varchar(300) not null,
lida boolean not null,
imagem blob null,
enviado_por enum('cliente','prestador') not null,
id_pedido int not null,
id_prestador int not null,
id_cliente int not null,
FOREIGN KEY (id_pedido) REFERENCES tbl_pedido (id_pedido),
FOREIGN KEY (id_prestador) REFERENCES tbl_prestador (id_prestador),
FOREIGN KEY (id_cliente) REFERENCES tbl_cliente (id_cliente)
);

CREATE TABLE tbl_veiculo_prestador(
id_veiculo_prestador int primary key auto_increment,
id_veiculo int not null,
id_prestador int not null,
FOREIGN KEY (id_veiculo) REFERENCES tbl_veiculo (id_veiculo),
FOREIGN KEY (id_prestador) REFERENCES tbl_prestador (id_prestador)
);

CREATE TABLE tbl_veiculo_cliente(
id_veiculo_cliente int primary key auto_increment,
id_veiculo int not null,
id_cliente int not null,
FOREIGN KEY (id_veiculo) REFERENCES tbl_veiculo (id_veiculo),
FOREIGN KEY (id_cliente) REFERENCES tbl_cliente (id_cliente)
);

CREATE TABLE tbl_prestador_servico(
id_prestador_servico int primary key auto_increment,
id_prestador int not null,
id_servicos int not null,
FOREIGN KEY (id_prestador) REFERENCES tbl_prestador (id_prestador),
FOREIGN KEY (id_servicos) REFERENCES tbl_servicos (id_servicos)
);

CREATE TABLE tbl_prestador_endereco(
id_prestador_endereco int primary key auto_increment,
id_prestador int not null,
id_endereco int not null,
FOREIGN KEY (id_prestador) REFERENCES tbl_prestador (id_prestador),
FOREIGN KEY (id_endereco) REFERENCES tbl_endereco (id_endereco)
);

CREATE TABLE tbl_cliente_endereco(
id_cliente_endereco int primary key auto_increment,
id_cliente int not null,
id_endereco int not null,
FOREIGN KEY (id_cliente) REFERENCES tbl_cliente (id_cliente),
FOREIGN KEY (id_endereco) REFERENCES tbl_endereco (id_endereco)
);



-- 1. BASE (Com IDs manuais para garantir o vínculo)
INSERT INTO tbl_cliente (id_cliente, nome, email, telefone, cpf, senha) VALUES 
(1, 'Ana Silva', 'ana@email.com', '11988887777', '12345678901', 'senha123'),
(2, 'Carlos Souza', 'carlos@email.com', '11977776666', '23456789012', 'senha456');

INSERT INTO tbl_prestador (id_prestador, nome, email, telefone, cpf, cnh, senha, categoria, descricao) VALUES 
(1, 'Marcos Frete', 'marcos@email.com', '11966665555', '34567890123', '98765432109', 'senha789', 'Mudanças', 'Especialista em mudanças'),
(2, 'José Entregas', 'jose@email.com', '11955554444', '45678901234', '87654321098', 'senha000', 'Entregas', 'Pequenos volumes');

INSERT INTO tbl_veiculo (id_veiculo, categoria, validade, codigo_renavam, placa) VALUES 
(1, 'Caminhão', '2027-12-31', '123456789012345', 'ABC1D23'),
(2, 'Moto', '2026-05-10', '543210987654321', 'XYZ9E87');

INSERT INTO tbl_servicos (id_servicos, nome_servico, descricao_servico) VALUES 
(1, 'Carreto', 'Transporte de móveis'),
(2, 'Logística', 'Entrega de documentos');

INSERT INTO tbl_endereco (id_endereco, cep, uf, cidade, logradouro, bairro) VALUES 
(1, '01001000', 'SP', 'São Paulo', 'Praça da Sé', 'Sé'),
(2, '06454000', 'SP', 'Barueri', 'Al. Rio Negro', 'Alphaville');

-- 2. VÍNCULOS (Agora os IDs 1 e 2 existem com certeza)
INSERT INTO tbl_veiculo_prestador (id_veiculo, id_prestador) VALUES (1, 1), (2, 2);
INSERT INTO tbl_veiculo_cliente (id_veiculo, id_cliente) VALUES (1, 2);
INSERT INTO tbl_prestador_servico (id_prestador, id_servicos) VALUES (1, 1), (2, 2);
INSERT INTO tbl_cliente_endereco (id_cliente, id_endereco) VALUES (1, 1), (2, 2);
INSERT INTO tbl_prestador_endereco (id_prestador, id_endereco) VALUES (1, 2), (2, 1);

-- 3. OPERAÇÃO
INSERT INTO tbl_pedido (id_pedido, data_solicitacao, endereco_destino, endereco_origem, descricao, distancia_km, id_cliente, id_prestador) VALUES 
(1, NOW(), 'Destino A', 'Origem B', 'Transporte de sofá', 15.0, 1, 1);

INSERT INTO tbl_status (status, id_pedido) VALUES (1, 1);

INSERT INTO tbl_mensagem (data_envio, texto_mensagem, lida, enviado_por, id_pedido, id_prestador, id_cliente) VALUES 
(NOW(), 'Olá, estou a caminho', 0, 'prestador', 1, 1, 1);

-- Nota: Se der erro aqui, verifique a TRIGGER de 'status_pedido' mencionada antes
INSERT INTO tbl_avaliacao (nota, comentario, id_pedido) VALUES (5.0, 'Excelente', 1);

SELECT * FROM tbl_cliente;
SELECT * FROM tbl_prestador;
SELECT * FROM tbl_veiculo;
SELECT * FROM tbl_servicos;
SELECT * FROM tbl_endereco;
SELECT * FROM tbl_pedido;
SELECT * FROM tbl_avaliacao;
SELECT * FROM tbl_mensagem;
SELECT * FROM tbl_veiculo_prestador;
SELECT * FROM tbl_veiculo_cliente;
SELECT * FROM tbl_prestador_servico;
SELECT * FROM tbl_prestador_endereco;
SELECT * FROM tbl_cliente_endereco;
SELECT * FROM tbl_status;




-- view da tela mensagem 
CREATE OR REPLACE VIEW vw_chat_dinamico AS
SELECT 
    m.id_pedido,
    m.data_envio,
    m.texto_mensagem,
    CASE 
        WHEN m.id_cliente IS NOT NULL THEN c.nome 
        ELSE p.nome 
    END AS nome_autor,
    CASE 
        WHEN m.id_cliente IS NOT NULL THEN c.img_perfil 
        ELSE p.img_perfil 
    END AS foto_autor,
    CASE 
        WHEN m.id_cliente IS NOT NULL THEN 'CLIENTE' 
        ELSE 'PRESTADOR' 
    END AS mensagem_autor
FROM tbl_mensagem m
LEFT JOIN tbl_cliente c ON m.id_cliente = c.id_cliente
LEFT JOIN tbl_prestador p ON m.id_prestador = p.id_prestador;

SELECT * FROM vw_chat_dinamico;
