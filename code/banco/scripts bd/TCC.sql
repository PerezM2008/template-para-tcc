CREATE DATABASE DRIVEZ00;
USE DRIVEZ00;

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
id_cliente int not null,
id_prestador int not null,
FOREIGN KEY (id_cliente) REFERENCES tbl_cliente (id_cliente),
FOREIGN KEY (id_prestador) REFERENCES tbl_prestador (id_prestador)
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

USE DRIVEZ00;

-- CLIENTES
INSERT INTO tbl_cliente
(nome,email,telefone,cpf,senha)
VALUES
('João Silva','joao@gmail.com','11987654321','12345678901','123456'),
('Maria Oliveira','maria@gmail.com','11987654322','12345678902','123456'),
('Carlos Santos','carlos@gmail.com','11987654323','12345678903','123456'),
('Ana Souza','ana@gmail.com','11987654324','12345678904','123456'),
('Pedro Lima','pedro@gmail.com','11987654325','12345678905','123456');

-- PRESTADORES
INSERT INTO tbl_prestador
(nome,email,telefone,cpf,cnh,senha,categoria,descricao)
VALUES
('Guincho Rápido','guincho1@gmail.com','11999990001','98765432101','123456789001','123456','Guincho Leve','Atendimento 24 horas'),
('Socorro Express','guincho2@gmail.com','11999990002','98765432102','123456789002','123456','Guincho Pesado','Guincho para caminhões'),
('Auto Help','autohelp@gmail.com','11999990003','98765432103','123456789003','123456','Mecânica','Socorro mecânico'),
('Resgate SP','resgate@gmail.com','11999990004','98765432104','123456789004','123456','Borracharia','Troca de pneus'),
('Drive Assist','driveassist@gmail.com','11999990005','98765432105','123456789005','123456','Bateria','Carga e troca de bateria');

-- VEÍCULOS
INSERT INTO tbl_veiculo
(categoria,validade,codigo_renavam,placa)
VALUES
('Hatch','2027-01-10','123456789000001','ABC1D23'),
('Sedan','2027-02-15','123456789000002','DEF2G34'),
('SUV','2027-03-20','123456789000003','GHI3J45'),
('Picape','2027-04-25','123456789000004','JKL4M56'),
('Moto','2027-05-30','123456789000005','NOP5Q67'),
('Guincho Leve','2028-01-10','123456789000006','RST6U78'),
('Guincho Pesado','2028-02-15','123456789000007','VWX7Y89'),
('Van Oficina','2028-03-20','123456789000008','ZAB8C90');

-- SERVIÇOS
INSERT INTO tbl_servicos
(nome_servico,descricao_servico)
VALUES
('Guincho','Reboque de veículos'),
('Troca de Pneu','Substituição de pneus'),
('Pane Seca','Fornecimento de combustível'),
('Carga de Bateria','Recarga emergencial'),
('Socorro Mecânico','Reparo básico no local');

-- ENDEREÇOS
INSERT INTO tbl_endereco
(cep,uf,cidade,logradouro,bairro)
VALUES
('06600000','SP','Jandira','Rua das Flores','Centro'),
('06602000','SP','Jandira','Rua São Paulo','Vila Eunice'),
('06604000','SP','Jandira','Rua das Acácias','Jardim Alvorada'),
('06400000','SP','Barueri','Alameda Rio Negro','Alphaville'),
('06000000','SP','Osasco','Avenida dos Autonomistas','Centro'),
('06110000','SP','Carapicuíba','Rua Amazonas','Centro'),
('06700000','SP','Cotia','Rua Cotia','Centro');

-- CLIENTE_ENDERECO
INSERT INTO tbl_cliente_endereco
(id_cliente,id_endereco)
VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5);

-- PRESTADOR_ENDERECO
INSERT INTO tbl_prestador_endereco
(id_prestador,id_endereco)
VALUES
(1,4),
(2,5),
(3,6),
(4,7),
(5,1);

-- VEICULO_CLIENTE
INSERT INTO tbl_veiculo_cliente
(id_veiculo,id_cliente)
VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5);

-- VEICULO_PRESTADOR
INSERT INTO tbl_veiculo_prestador
(id_veiculo,id_prestador)
VALUES
(6,1),
(7,2),
(8,3);

-- PRESTADOR_SERVICO
INSERT INTO tbl_prestador_servico
(id_prestador,id_servicos)
VALUES
(1,1),
(1,2),
(2,1),
(3,5),
(4,2),
(5,4);

-- PEDIDOS
INSERT INTO tbl_pedido
(data_solicitacao,endereco_destino,endereco_origem,descricao,distancia_km,id_cliente,id_prestador)
VALUES
('2026-06-01 08:15:00','Centro, Jandira - SP','Vila Eunice, Jandira - SP','Veículo não liga',3.500,1,5),
('2026-06-01 09:20:00','Alphaville, Barueri - SP','Centro, Jandira - SP','Necessário guincho',8.200,2,1),
('2026-06-02 10:00:00','Centro, Osasco - SP','Alphaville, Barueri - SP','Pneu furado',5.700,3,4),
('2026-06-03 11:30:00','Centro, Carapicuíba - SP','Centro, Osasco - SP','Pane seca',4.300,4,3),
('2026-06-04 14:00:00','Centro, Cotia - SP','Jardim Alvorada, Jandira - SP','Reboque até oficina',12.800,5,2);

-- STATUS
INSERT INTO tbl_status
(status,id_pedido)
VALUES
('Concluído',1),
('Em andamento',2),
('Concluído',3),
('Cancelado',4),
('Aguardando prestador',5);

-- AVALIAÇÕES
INSERT INTO tbl_avaliacao
(nota,comentario,id_cliente,id_prestador)
VALUES
(5.0,'Atendimento excelente',1,5),
(4.5,'Chegou rápido',2,1),
(4.0,'Resolveu o problema',3,4),
(3.5,'Demorou um pouco',4,3),
(5.0,'Muito profissional',5,2);

-- MENSAGENS
INSERT INTO tbl_mensagem
(data_envio,texto_mensagem,lida,enviado_por,id_pedido,id_prestador,id_cliente)
VALUES
('2026-06-01 08:20:00','Estou a caminho.',1,'prestador',1,5,1),
('2026-06-01 09:25:00','Qual a localização exata?',1,'prestador',2,1,2),
('2026-06-01 09:27:00','Próximo ao mercado central.',1,'cliente',2,1,2),
('2026-06-02 10:10:00','Chego em 10 minutos.',0,'prestador',3,4,3),
('2026-06-04 14:15:00','Pedido recebido.',0,'prestador',5,2,5);

USE DRIVEZ00;

SELECT * FROM tbl_cliente;

SELECT * FROM tbl_prestador;

SELECT * FROM tbl_veiculo;

SELECT * FROM tbl_servicos;

SELECT * FROM tbl_endereco;

SELECT * FROM tbl_pedido;

SELECT * FROM tbl_status;

SELECT * FROM tbl_avaliacao;

SELECT * FROM tbl_mensagem;

SELECT * FROM tbl_veiculo_prestador;

SELECT * FROM tbl_veiculo_cliente;

SELECT * FROM tbl_prestador_servico;

SELECT * FROM tbl_prestador_endereco;

SELECT * FROM tbl_cliente_endereco;


INSERT INTO tbl_prestador (nome, email, telefone, img_perfil, cpf, cnh, cnpj, senha) VALUES
('Arthur Oliveira', 'arthur.oliveira@email.com', '11988786767', 'https://randomuser.me/api/portraits/men/11.jpg', '98667431100', '12314608910', NULL, 'senha123'),

('Carlos Henrique Souza', 'carlos.souza@email.com', '11988786768', 'https://randomuser.me/api/portraits/men/12.jpg', '98667431101', '12314608911', NULL, 'senha123'),

('Rafael Martins Silva', 'rafael.silva@email.com', '11988786769', 'https://randomuser.me/api/portraits/men/13.jpg', '98667431102', '12314608912', NULL, 'senha123'),

('Gabriel Ferreira Costa', 'gabriel.costa@email.com', '11988786770', 'https://randomuser.me/api/portraits/men/14.jpg', '98667431103', '12314608913', NULL, 'senha123'),

('Lucas Almeida Santos', 'lucas.santos@email.com', '11988786771', 'https://randomuser.me/api/portraits/men/15.jpg', '98667431104', '12314608914', NULL, 'senha123'),

('Matheus Rodrigues Lima', 'matheus.lima@email.com', '11988786772', 'https://randomuser.me/api/portraits/men/16.jpg', '98667431105', '12314608915', NULL, 'senha123'),

('Bruno Carvalho Gomes', 'bruno.gomes@email.com', '11988786773', 'https://randomuser.me/api/portraits/men/17.jpg', '98667431106', '12314608916', NULL, 'senha123'),

('Felipe Rocha Pereira', 'felipe.pereira@email.com', '11988786774', 'https://randomuser.me/api/portraits/men/18.jpg', '98667431107', '12314608917', NULL, 'senha123'),

('Thiago Mendes Ribeiro', 'thiago.ribeiro@email.com', '11988786775', 'https://randomuser.me/api/portraits/men/19.jpg', '98667431108', '12314608918', NULL, 'senha123'),

('André Vinicius Barbosa', 'andre.barbosa@email.com', '11988786776', 'https://randomuser.me/api/portraits/men/20.jpg', '98667431109', '12314608919', NULL, 'senha123');


INSERT INTO tbl_cliente (nome, email, telefone, img_perfil, cpf, cnpj, senha) VALUES
('Carlos Eduardo Silva', 'carlos.silva@email.com', '11987654321', 'https://randomuser.me/api/portraits/men/1.jpg', '12345678901', NULL, '12345'),

('Marcos Vinicius Souza', 'marcos.souza@email.com', '11987654322', 'https://randomuser.me/api/portraits/men/2.jpg', '12345678902', NULL, '12345'),

('Ricardo Almeida Santos', 'ricardo.santos@email.com', '11987654323', 'https://randomuser.me/api/portraits/men/3.jpg', '12345678903', NULL, '12345'),

('Fernando Oliveira Lima', 'fernando.lima@email.com', '11987654324', 'https://randomuser.me/api/portraits/men/4.jpg', '12345678904', NULL, '12345'),

('Gustavo Henrique Costa', 'gustavo.costa@email.com', '11987654325', 'https://randomuser.me/api/portraits/men/5.jpg', '12345678905', NULL, '12345'),

('Juliana Ferreira Rocha', 'juliana.rocha@email.com', '11987654326', 'https://randomuser.me/api/portraits/women/1.jpg', '12345678906', NULL, '12345'),

('Amanda Cristina Martins', 'amanda.martins@email.com', '11987654327', 'https://randomuser.me/api/portraits/women/2.jpg', '12345678907', NULL, '12345'),

('Patrícia Gomes Ribeiro', 'patricia.ribeiro@email.com', '11987654328', 'https://randomuser.me/api/portraits/women/3.jpg', '12345678908', NULL, '12345'),

('Camila Alves Pereira', 'camila.pereira@email.com', '11987654329', 'https://randomuser.me/api/portraits/women/4.jpg', '12345678909', NULL, '12345'),

('Beatriz Santos Carvalho', 'beatriz.carvalho@email.com', '11987654330', 'https://randomuser.me/api/portraits/women/5.jpg', '12345678910', NULL, '12345');


INSERT INTO tbl_pedido (
    data_solicitacao,
    endereco_destino,
    endereco_origem,
    descricao,
    distancia_km,
    id_cliente,
    id_prestador
) VALUES

('2026-02-11', 'Centro, Jandira - SP', 'Vila Santo Antônio, Jandira - SP', 'Preciso de um guincho.', 5.2, 1, 1),

('2026-02-12', 'Parque Santa Tereza, Carapicuíba - SP', 'Centro, Barueri - SP', 'Pneu furado na rodovia.', 8.7, 2, 2),

('2026-02-13', 'Alphaville, Barueri - SP', 'Jardim Belval, Barueri - SP', 'Veículo não liga.', 12.3, 3, 3),

('2026-02-14', 'Centro, Osasco - SP', 'Jaguaribe, Osasco - SP', 'Necessito de socorro mecânico.', 6.9, 4, 4),

('2026-02-15', 'Granja Viana, Cotia - SP', 'Centro, Cotia - SP', 'Bateria descarregada.', 14.1, 5, 5),

('2026-02-16', 'Tamboré, Santana de Parnaíba - SP', 'Centro, Santana de Parnaíba - SP', 'Solicitação de guincho para veículo.', 10.5, 6, 6),

('2026-02-17', 'Jardim das Flores, Osasco - SP', 'Presidente Altino, Osasco - SP', 'Problema no motor.', 4.8, 7, 7),

('2026-02-18', 'Centro, Itapevi - SP', 'Jardim Portela, Itapevi - SP', 'Pane elétrica no carro.', 7.6, 8, 8),

('2026-02-19', 'Centro, Embu das Artes - SP', 'Jardim Santa Tereza, Embu das Artes - SP', 'Preciso trocar o pneu.', 9.4, 9, 9),

('2026-02-20', 'Centro, Taboão da Serra - SP', 'Parque Pinheiros, Taboão da Serra - SP', 'Guincho para levar veículo à oficina.', 11.2, 10, 10);
