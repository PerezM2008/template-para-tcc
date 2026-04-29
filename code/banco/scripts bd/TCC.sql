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
senha varchar(100) not null
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
status_pedido enum("Pendente","Em andamento","Finalizado") not null,
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

INSERT INTO tbl_cliente (nome, email, telefone,img_perfil, cpf, cnpj, senha) VALUES
('Ana Silva', 'ana.silva@email.com', '11988887777', '12345678901', '12345678000101', 'hash_senha_1'),
('Bruno Oliveira', 'bruno.o@provedor.com', '21977776666', '23456789012', '23456789000112', 'hash_senha_2'),
('Carla Souza', 'contato@carla.me', '31966665555', '34567890123', '34567890000123', 'hash_senha_3'),
('Diego Santos', 'diego.santos@web.com', '41955554444', '45678901234', '45678901000134', 'hash_senha_4'),
('Elena Martins', 'elena.m@empresa.com', '51944443333', '56789012345', '56789012000145', 'hash_senha_5'),
('Fabio Lima', 'fabio.lima@servidor.br', '61933332222', '67890123456', '67890123000156', 'hash_senha_6'),
('Gisele Rocha', 'gisele_rocha@mail.com', '71922221111', '78901234567', '78901234000167', 'hash_senha_7'),
('Hugo Ferreira', 'hugo.f@tech.com', '81911110000', '89012345678', '89012345000178', 'hash_senha_8'),
('Irene Costa', 'irene.costa@ig.com', '91900009999', '90123456789', '90123456000189', 'hash_senha_9'),
('João Mendes', 'joao.mendes@uol.com', '11912345678', '01234567890', '01234567000190', 'hash_senha_10');

INSERT INTO tbl_prestador (nome, email, telefone, cpf, cnh, cnpj, senha) VALUES
('Carlos Entregas', 'carlos@logistica.com', '11911112222', '10120230344', '123456789012', '11122233000101', 'hash_p1'),
('Marcos Reparos', 'marcos.reparos@email.com', '21922223333', '20230340455', '234567890123', '22233344000112', 'hash_p2'),
('Julia Reformas', 'contato@juliaref.com', '31933334444', '30340450566', '345678901234', '33344455000123', 'hash_p3'),
('Roberto Fretes', 'beto.fretes@uol.com', '41944445555', '40450560677', '456789012345', '44455566000134', 'hash_p4'),
('Luciana Pinturas', 'lu.pinturas@web.com', '51955556666', '50560770788', '567890123456', '55566677000145', 'hash_p5'),
('Ricardo Elétrica', 'ricardo.ele@gmail.com', '61966667777', '60670880899', '678901234567', '66677788000156', 'hash_p6'),
('Fernanda Limpeza', 'fer.limp@servicos.com', '71977778888', '70780990900', '789012345678', '77788899000167', 'hash_p7'),
('Paulo Hidráulica', 'paulo.hidro@ig.com', '81988889999', '80891001011', '890123456789', '88899900000178', 'hash_p8'),
('Sandra Mudanças', 'sandra.mud@empresa.br', '91999990000', '90901112122', '901234567890', '99900011000189', 'hash_p9'),
('Thiago Assistência', 'thiago.tec@outlook.com', '11900001111', '01012223233', '012345678901', '00011122000190', 'hash_p10');

INSERT INTO tbl_veiculo (categoria, validade, codigo_renavam, placa) VALUES
('Caminhão Baú', '2026-12-31', '12345678901', 'ABC1D23'),
('Van de Carga', '2025-10-15', '23456789012', 'EFG2H34'),
('Motocicleta', '2027-05-20', '34567890123', 'IJK3L45'),
('Utilitário', '2026-08-12', '45678901234', 'MNO4P56'),
('Caminhão Sider', '2025-11-30', '56789012345', 'QRS5T67'),
('Carro Passeio', '2028-01-10', '67890123456', 'UVW6X78'),
('Furgão', '2026-03-25', '78901234567', 'YZA7B89'),
('Caminhão Truck', '2025-09-05', '89012345678', 'BCD8E90'),
('Pickup', '2027-07-14', '90123456789', 'FGH9I01'),
('Caminhão Tanque', '2026-06-18', '01234567890', 'JKL0M12');

INSERT INTO tbl_servicos (nome_servico, descricao_servico) VALUES
('Revisão Geral', 'Check-up completo de motor, freios, suspensão e fluidos do veículo.'),
('Troca de Óleo e Filtro', 'Substituição de óleo lubrificante e filtros de ar e combustível.'),
('Manutenção de Freios', 'Troca de pastilhas, discos e verificação do sistema hidráulico.'),
('Reparo de Suspensão', 'Substituição de amortecedores, buchas e pivôs.'),
('Alinhamento e Balanceamento', 'Ajuste da geometria das rodas para evitar desgaste irregular.'),
('Mecânica de Motor', 'Reparos em cabeçote, correia dentada e sistemas internos.'),
('Diagnóstico Scanner', 'Leitura eletrônica de falhas na injeção e sensores do veículo.'),
('Manutenção de Câmbio', 'Reparo em transmissões manuais e automáticas.'),
('Sistema Elétrico', 'Reparo em alternadores, baterias e motor de arranque.'),
('Ar-Condicionado Automotivo', 'Carga de gás, higienização e reparo no compressor.');

INSERT INTO tbl_endereco (cep, uf, cidade, logradouro, bairro) VALUES
('01310100', 'SP', 'São Paulo', 'Avenida Paulista, 1000', 'Bela Vista'),
('20040002', 'RJ', 'Rio de Janeiro', 'Avenida Rio Branco, 156', 'Centro'),
('30140010', 'MG', 'Belo Horizonte', 'Rua da Bahia, 900', 'Lourdes'),
('70070010', 'DF', 'Brasília', 'SBS Quadra 1', 'Asa Sul'),
('80020010', 'PR', 'Curitiba', 'Rua XV de Novembro, 200', 'Centro'),
('90010190', 'RS', 'Porto Alegre', 'Rua dos Andradas, 500', 'Centro Histórico'),
('40020160', 'BA', 'Salvador', 'Praça da Sé, 10', 'Pelourinho'),
('60060390', 'CE', 'Fortaleza', 'Rua Guilherme Rocha, 300', 'Centro'),
('88010000', 'SC', 'Florianópolis', 'Rua Felipe Schmidt, 450', 'Centro'),
('69005000', 'AM', 'Manaus', 'Avenida Eduardo Ribeiro, 600', 'Centro');

INSERT INTO tbl_pedido (status_pedido, data_solicitacao, endereco_destino, endereco_origem, descricao, distancia_km, id_cliente, id_prestador) VALUES
('Pendente', '2026-04-20 10:30:00', 'Rua das Flores, 123', 'Av. Paulista, 1000', 'Troca de óleo e filtro', 5.500, 1, 1),
('Em andamento', '2026-04-21 14:00:00', 'Rua Rio Branco, 50', 'Rua da Bahia, 900', 'Manutenção de freios', 12.350, 2, 2),
('Finalizado', '2026-04-22 09:15:00', 'Av. Brasil, 2000', 'Rua XV de Novembro, 200', 'Revisão geral de suspensão', 8.100, 3, 3),
('Pendente', '2026-04-23 16:45:00', 'Rua dos Andradas, 300', 'Av. Eduardo Ribeiro, 600', 'Reparo no sistema elétrico', 3.200, 4, 4),
('Em andamento', '2026-04-24 08:30:00', 'Praça da Sé, 5', 'Rua Guilherme Rocha, 150', 'Diagnóstico via scanner', 15.000, 5, 5),
('Finalizado', '2026-04-24 11:00:00', 'Al. Santos, 450', 'Rua Augusta, 1200', 'Troca de pastilhas', 2.850, 6, 6),
('Pendente', '2026-04-24 13:20:00', 'Rua Chile, 22', 'Av. Sete de Setembro, 80', 'Carga de gás ar-condicionado', 7.400, 7, 7),
('Em andamento', '2026-04-24 15:10:00', 'Rua da Praia, 10', 'Av. Ipiranga, 500', 'Manutenção de embreagem', 22.600, 8, 8),
('Finalizado', '2026-04-24 16:00:00', 'Rua do Ouvidor, 15', 'Av. Rio Branco, 200', 'Alinhamento e balanceamento', 4.150, 9, 9),
('Pendente', '2026-04-24 17:30:00', 'Rua Direita, 100', 'Pátio do Colégio, 1', 'Reparo de motor de arranque', 1.500, 10, 10);

INSERT INTO tbl_avaliacao (nota, comentario, id_pedido) VALUES
(5.0, 'Serviço excelente! O mecânico foi muito rápido e educado.', 1),
(4.5, 'Muito bom, mas demorou um pouco para chegar ao local.', 2),
(5.0, 'Profissional extremamente qualificado, resolveu o problema de primeira.', 3),
(3.0, 'O serviço foi ok, mas o valor ficou um pouco acima do esperado.', 4),
(4.0, 'Bom atendimento, recomendo para serviços de suspensão.', 5),
(5.0, 'Impecável. Troca de pastilhas feita em tempo recorde.', 6),
(2.5, 'O ar-condicionado voltou a gelar, mas o prestador sujou o banco.', 7),
(4.8, 'Excelente custo-benefício. Voltarei a contratar.', 8),
(5.0, 'Alinhamento perfeito, o carro está outro.', 9),
(4.2, 'Atendimento atencioso e explicação técnica bem clara.', 10);

INSERT INTO tbl_mensagem (data_envio, texto_mensagem, lida, id_pedido, id_prestador, id_cliente) VALUES
('2026-04-24 10:35:00', 'Olá, já estou a caminho do local.', 1, 1, 1, 1),
('2026-04-24 10:37:00', 'Perfeito, ficarei aguardando na garagem.', 1, 1, 1, 1),
('2026-04-24 14:05:00', 'Pode me enviar uma foto da peça que precisa ser trocada?', 1, 2, 2, 2),
('2026-04-24 14:10:00', 'Vou tirar a foto agora e te mando.', 0, 2, 2, 2),
('2026-04-24 09:20:00', 'O serviço de suspensão foi finalizado com sucesso.', 1, 3, 3, 3),
('2026-04-24 16:50:00', 'Você trabalha com peças originais ou paralelas?', 1, 4, 4, 4),
('2026-04-24 16:55:00', 'Trabalho com ambas, depende da sua preferência.', 1, 4, 4, 4),
('2026-04-24 08:40:00', 'Estou tendo problemas para encontrar o endereço, pode confirmar?', 1, 5, 5, 5),
('2026-04-24 08:42:00', 'É na casa de portão azul, logo após o mercado.', 1, 5, 5, 5),
('2026-04-24 11:15:00', 'Obrigado pelo serviço, o carro ficou ótimo!', 0, 6, 6, 6);

INSERT INTO tbl_cliente (nome, email, telefone, img_perfil, cpf, cnpj, senha) VALUES
('Ricardo Almeida', 'ricardo.almeida@email.com', '11988887777', 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', '12345678961', NULL, 'senha123'),
('Juliana Costa', 'ju.costa@email.com', '11977776666', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=500', '23456789612', NULL, 'senha456'),
('Marcos Oliveira', 'marcos.mecanica@email.com', '11966665555', 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=500', '34567896123', NULL, 'senha789'),
('Fernanda Souza', 'fer.souza@email.com', '11955554444', 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=500', '45678961234', NULL, 'senha101'),
('Bruno Martins', 'bruno.log@email.com', '11944443333', 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=500', '56789612345', NULL, 'senha202');

INSERT INTO tbl_prestador (nome, email, telefone, img_perfil, cpf, cnpj,cnh, senha) VALUES
('Mecânica do Giba', 'contato@giba.com', '11911112222', 'https://images.unsplash.com/photo-1552058544-f2b08422138a?w=500', 58126584807, '12345678000199', '12345678911','giba123'),
('Auto Elétrica Faísca', 'faisca@email.com', '11922223333', 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=500', 31638508801, '98765432000188','12345678912', 'faisca456');

-- Juliana (Cliente) pergunta
INSERT INTO tbl_mensagem (id_pedido, id_cliente, id_prestador, texto_mensagem, lida, data_envio)
VALUES (1, 2, NULL, 'Oi Giba, consegue chegar em 20 minutos?', 0, now());

-- Giba (Prestador) responde
INSERT INTO tbl_mensagem (id_pedido, id_cliente, id_prestador, texto_mensagem, lida, data_envio)
VALUES (1, NULL, 1, 'Consigo sim, Juliana! Já estou entrando na sua rua.', 0, now());

SELECT 
    nome_autor, 
    papel_autor, 
    texto_mensagem, 
    foto_autor 
FROM vw_chat_dinamico 
WHERE id_pedido = 1 
ORDER BY data_envio ASC;

INSERT INTO tbl_veiculo_prestador (id_veiculo, id_prestador) VALUES
(1, 1), -- Caminhão Baú vinculado ao Carlos Entregas
(2, 2), -- Van de Carga vinculada ao Marcos Reparos
(3, 3), -- Motocicleta vinculada à Julia Reformas
(4, 4), -- Utilitário vinculado ao Roberto Fretes
(5, 5), -- Caminhão Sider vinculado à Luciana Pinturas
(6, 6), -- Carro Passeio vinculado ao Ricardo Elétrica
(7, 7), -- Furgão vinculado à Fernanda Limpeza
(8, 8), -- Caminhão Truck vinculado ao Paulo Hidráulica
(9, 9), -- Pickup vinculada à Sandra Mudanças
(10, 10); -- Caminhão Tanque vinculado ao Thiago Assistência

INSERT INTO tbl_veiculo_cliente (id_veiculo, id_cliente) VALUES
(1, 1), 
(2, 2), 
(3, 3), 
(4, 4), 
(5, 5), 
(6, 6), 
(7, 7), 
(8, 8), 
(9, 9), 
(10, 10);

INSERT INTO tbl_prestador_servico (id_prestador, id_servicos) VALUES
(1, 1), -- Carlos faz Revisão Geral
(2, 2), -- Marcos faz Troca de Óleo
(3, 3), -- Julia faz Manutenção de Freios
(4, 4), -- Roberto faz Reparo de Suspensão
(5, 5), -- Luciana faz Alinhamento
(6, 6), -- Ricardo faz Mecânica de Motor
(7, 7), -- Fernanda faz Diagnóstico Scanner
(8, 8), -- Paulo faz Manutenção de Câmbio
(9, 9), -- Sandra faz Sistema Elétrico
(10, 10); -- Thiago faz Ar-condicionado

INSERT INTO tbl_prestador_endereco (id_prestador, id_endereco) VALUES
(1, 1), -- Carlos em São Paulo
(2, 2), -- Marcos no Rio de Janeiro
(3, 3), -- Julia em Belo Horizonte
(4, 4), -- Roberto em Brasília
(5, 5), -- Luciana em Curitiba
(6, 6), -- Ricardo em Porto Alegre
(7, 7), -- Fernanda em Salvador
(8, 8), -- Paulo em Fortaleza
(9, 9), -- Sandra em Florianópolis
(10, 10); -- Thiago em Manaus

INSERT INTO tbl_cliente_endereco (id_cliente, id_endereco) VALUES
(1, 1), -- Ana Silva vinculada ao endereço de SP
(2, 2), -- Bruno Oliveira vinculado ao endereço do RJ
(3, 3), -- Carla Souza vinculada ao endereço de MG
(4, 4), -- Diego Santos vinculado ao endereço do DF
(5, 5), -- Elena Martins vinculada ao endereço do PR
(6, 6), -- Fabio Lima vinculado ao endereço do RS
(7, 7), -- Gisele Rocha vinculada ao endereço da BA
(8, 8), -- Hugo Ferreira vinculado ao endereço do CE
(9, 9), -- Irene Costa vinculada ao endereço de SC
(10, 10); -- João Mendes vinculado ao endereço do AM


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




-- Relatorio completo
SELECT 
    p.id_pedido AS 'Nº Pedido',
    ANY_VALUE(p.status_pedido) AS 'Status',
    ANY_VALUE(p.data_solicitacao) AS 'Data',
    ANY_VALUE(p.descricao) AS 'O que foi pedido',
    -- Dados do Cliente e seu Veículo
    ANY_VALUE(c.nome) AS 'Cliente',
    ANY_VALUE(v_cli.placa) AS 'Placa Cli',
    -- Dados do Prestador e seu Veículo
    ANY_VALUE(pr.nome) AS 'Prestador',
    ANY_VALUE(v_pre.placa) AS 'Placa Prest',
    -- Localização
    ANY_VALUE(p.endereco_origem) AS 'Origem',
    ANY_VALUE(p.endereco_destino) AS 'Destino',
    ANY_VALUE(e_cli.cidade) AS 'Cidade Cliente',
    ANY_VALUE(e_pre.cidade) AS 'Cidade Prestador',
    -- Avaliação
    ANY_VALUE(a.nota) AS 'Nota',
    ANY_VALUE(a.comentario) AS 'Feedback'
FROM tbl_pedido p
JOIN tbl_cliente c ON p.id_cliente = c.id_cliente
LEFT JOIN tbl_veiculo_cliente vc ON c.id_cliente = vc.id_cliente
LEFT JOIN tbl_veiculo v_cli ON vc.id_veiculo = v_cli.id_veiculo
LEFT JOIN tbl_cliente_endereco ce ON c.id_cliente = ce.id_cliente
LEFT JOIN tbl_endereco e_cli ON ce.id_endereco = e_cli.id_endereco
JOIN tbl_prestador pr ON p.id_prestador = pr.id_prestador
LEFT JOIN tbl_veiculo_prestador vp ON pr.id_prestador = vp.id_prestador
LEFT JOIN tbl_veiculo v_pre ON vp.id_veiculo = v_pre.id_veiculo
LEFT JOIN tbl_prestador_endereco pe ON pr.id_prestador = pe.id_prestador
LEFT JOIN tbl_endereco e_pre ON pe.id_endereco = e_pre.id_endereco
LEFT JOIN tbl_avaliacao a ON p.id_pedido = a.id_pedido
GROUP BY p.id_pedido;





-- TESTE VIEWS 

CREATE VIEW vw_resumo_pedidos AS
SELECT 
    p.id_pedido,
    c.nome AS nome_cliente,
    pr.nome AS nome_prestador,
    p.status_pedido,
    p.data_solicitacao
FROM tbl_pedido p
JOIN tbl_cliente c ON p.id_cliente = c.id_cliente
JOIN tbl_prestador pr ON p.id_prestador = pr.id_prestador;

SELECT * FROM vw_resumo_pedidos;


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

-- view da tela historico pedidos, (cliente e prestador)
CREATE OR REPLACE VIEW vw_historico_pedidos_finalizados AS
SELECT 
    p.id_pedido,            
    p.id_cliente,
    p.id_prestador,            
    pr.nome AS nome_prestador,
    c.nome AS nome_cliente,
    p.endereco_origem,
    p.endereco_destino,
    p.data_solicitacao AS data_pedido
FROM tbl_pedido p
JOIN tbl_cliente c ON p.id_cliente = c.id_cliente
JOIN tbl_prestador pr ON p.id_prestador = pr.id_prestador
WHERE p.status_pedido = 'Finalizado';

-- select abaixo se precisar para montar!
SELECT 
    id_pedido,
      id_cliente,
    id_prestador,
    nome_cliente,
    nome_prestador, 
    endereco_origem, 
    endereco_destino, 
    data_pedido
FROM vw_historico_pedidos_finalizados
WHERE id_cliente = 1;


-- TRIGGERS 

-- Finalizar Pedido, esta funcionando!

DELIMITER //
CREATE TRIGGER trg_finalizar_pedido_apos_avaliacao
AFTER INSERT ON tbl_avaliacao
FOR EACH ROW
BEGIN
    UPDATE tbl_pedido 
    SET status_pedido = 'Finalizado'
    WHERE id_pedido = NEW.id_pedido;
END //
DELIMITER ;



-- testando a trigger "trg_finalizar_pedido_apos_avaliacao"
INSERT INTO tbl_avaliacao (id_pedido, nota, comentario) 
VALUES (11, 5, 'Serviço excelente!');
DELETE FROM tbl_avaliacao WHERE id_pedido = 8;
SELECT id_pedido, status_pedido FROM tbl_pedido WHERE id_pedido = 11;


-- Validar Autor Da mensagem. esta funcionando!
DELIMITER //
CREATE TRIGGER trg_validar_autor_mensagem
BEFORE INSERT ON tbl_mensagem
FOR EACH ROW
BEGIN
	IF (NEW.id_cliente IS NULL AND NEW.id_prestador IS NULL) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: A mensagem deve ter um autor (Cliente ou Prestador).';
    END IF;
END //
DELIMITER ;

-- testando a trigger "trg_validar_autor_mensagem"
INSERT INTO tbl_mensagem (id_pedido, id_cliente, id_prestador, texto_mensagem)
VALUES (1, NULL, NULL, 'Essa mensagem não deve passar!');


SELECT * FROM vw_chat_dinamico WHERE id_pedido = 1;

-- Bloquear avaliacao dupla no sistema, esta funcionando!
DELIMITER //
CREATE TRIGGER trg_bloquear_avaliacao_dupla
BEFORE INSERT ON tbl_avaliacao
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM tbl_avaliacao WHERE id_pedido = NEW.id_pedido) > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Este pedido já foi avaliado!';
    END IF;
END //
DELIMITER ;


-- TESTE DE NOVAS TRIGGERS --

-- Garante que a data do pedido seja o momento exato da inserção, trigger funcionando
DELIMITER $$
CREATE TRIGGER tr_data_pedido_insert
BEFORE INSERT ON tbl_pedido
FOR EACH ROW
BEGIN
    IF NEW.data_solicitacao IS NULL THEN
        SET NEW.data_solicitacao = NOW();
    END IF;
END$$
DELIMITER ;


-- Garante que a data da mensagem seja o momento exato do envio, trigger funcionando!
DELIMITER $$
CREATE TRIGGER tr_data_mensagem_insert
BEFORE INSERT ON tbl_mensagem
FOR EACH ROW
BEGIN
    SET NEW.data_envio = NOW();
END$$
DELIMITER ;


-- Impede que o pedido "CLIENTE" seja feito sem cpf ou cnpj, trigger funcionando!
DELIMITER $$
CREATE TRIGGER tr_valida_documento_cliente_update
BEFORE UPDATE ON tbl_cliente
FOR EACH ROW
BEGIN
    -- Só valida se ele estiver tentando mexer nos campos de documento
    IF NEW.cpf IS NULL AND NEW.cnpj IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Para completar o cadastro, insira ao menos um CPF ou CNPJ.';
    END IF;
END$$
DELIMITER ;


-- Impede que o pedido "PRESTADOR" seja feito sem cpf ou cnpj, trigger funcionando!
DELIMITER $$
CREATE TRIGGER tr_valida_documento_prestador_update
BEFORE UPDATE ON tbl_prestador
FOR EACH ROW
BEGIN
    IF NEW.cpf IS NULL AND NEW.cnpj IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'O prestador deve possuir pelo menos um CPF ou CNPJ.';
    END IF;
    -- Se você quiser garantir que o prestador sempre tenha telefone ao atualizar
    IF NEW.telefone IS NULL OR NEW.telefone = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O prestador precisa de um telefone para contato.';
    END IF;
END$$
DELIMITER ;


-- impede que o pedido seja feito se o cliente nao tiver feito todo o cadastro obrigatorio
DELIMITER $$
CREATE TRIGGER tr_valida_cadastro_antes_pedido
BEFORE INSERT ON tbl_pedido
FOR EACH ROW
BEGIN
    DECLARE v_telefone VARCHAR(14);
    DECLARE v_cpf VARCHAR(11);
    DECLARE v_cnpj VARCHAR(14);
    -- Busca os dados do cliente que está tentando fazer o pedido
    SELECT telefone, cpf, cnpj 
    INTO v_telefone, v_cpf, v_cnpj
    FROM tbl_cliente
    WHERE id_cliente = NEW.id_cliente;
    -- Verifica se o telefone está preenchido
    IF v_telefone IS NULL OR v_telefone = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Complete seu cadastro (telefone) para realizar pedidos.';
    END IF;
    -- Verifica se existe pelo menos um documento (CPF ou CNPJ)
    IF v_cpf IS NULL AND v_cnpj IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Complete seu cadastro (CPF ou CNPJ) para realizar pedidos.';
    END IF;
END$$
DELIMITER ;