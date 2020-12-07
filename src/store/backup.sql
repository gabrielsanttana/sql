use mercearia
go

insert into cargo
values 
('Operador(a) de Caixa', 'Responsável pela opereção dos caixas'),
('Repositor(a)', 'Reponsável pela reposição dos produtos'),
('Padeiro(a)', 'Responsável pela confeição dos produtos da padaria'),
('Auxiliar de Limpeza', 'Responsável pela limpeza da loja'),
('Gerente', 'Responsável pela administração da loja')
go

insert into endereco
values
('Rua Jundiaí', 1000, 'Parque das Nações', 'Campinas', 'SP'),
('Rua Jundiaí', 1000, 'Parque das Peras', 'Campinas', 'SP'),
('Rua Jundiaí', 1000, 'Parque das Maçãs', 'Campinas', 'SP'),
('Rua Jundiaí', 1000, 'Parque das Uvas', 'Campinas', 'SP'),
('Rua Jundiaí', 1000, 'Parque das Bananas', 'Campinas', 'SP')
go

insert into pessoa
values
('gabriel@gmail.com',1),
('maria@gmail.com',1),
('daniel@gmail.com',1),
('luana@gmail.com',1),
('juliana@gmail.com',1),
('contato@sadia.com',2),
('contato@perdigão.com',3),
('contato@nestle.com',4),
('contato@panco.com',5),
('contato@ambev.com',5),
('contato@jbs.com',5),
('contato@ipê.com',5)
go

insert into fornecedor
values
(6, '06.777.590/0001-23', 'Sadia', 'Sadia'),
(7, '06.778.590/0001-17', 'Perdigão', 'Perdigão'),
(8, '06.779.590/0001-18', 'Nestle', 'Nestle' ),
(9, '06.800.591/0001-21', 'Panco', 'Panco'),
(10, '06.800.592/0001-21', 'Ambev', 'Ambev'),
(11, '06.800.593/0001-21', 'JBS', 'JBS'),
(12, '06.801.590/0001-22', 'Ipê', 'Ipê')
go

insert into categoria
values
('Padaria', 'Padaria'),
('Limpeza', 'Limpeza'),
('Utilidades Domésticas', 'Utilidades Domésticas'),
('Higiene', 'Higiene'),
('Bebidas', 'Bebidas'),
('Carnes', 'Carnes'),
('Matinais', 'Matinais'),
('Frios e Laticínios', 'Frios e Laticínios')
go

insert into unidade_medida
values
('Grama', 'g'),
('Litro', 'L'),
('Unidade', 'u')
go

insert into produto
values
('Pão de Forma Panco', 1, 1, 1, 3.0, 10, '1234567891012'),
('Detergente Ipê Coco', 1, 2, 2, 1.50, 10, '1234567891013'),
('Espremedor de Alho', 1, 3, 3, 1.50, 10, '1234567891014'),
('Papel Higiênico', 1, 3, 4, 5.0, 10, '1234567891015'),
('Cerveja Stella Artois', 2, 1, 5, 2.70, 10, '1234567891016'),
('Peça de Picanha', 1, 1, 6, 80.0, 10, '1234567891018'),
('Leite Líder', 1, 2, 7, 2.40, 10, '1234567891019'),
('Mortadela', 1, 1, 8, 3.0, 10, '1234567891010')
go

insert into fornecedor_produto
values
(7, 8),
(9, 7),
(10, 6)
go

insert into pessoa_fisica
values
(1,44455576678, 'Gabriel Marques'),
(2,44455586678, 'Maria Marques'),
(3,44455596678, 'Daniel Marques'),
(4,44455516678, 'Luana Marques'),
(5,44455536678, 'Juliana Marques')
go

insert into cliente
values
(1, 391445886, '30-04-1980'),
(2, 391446886, '30-05-1980'),
(3, 391447886, '30-06-1980'),
(4, 391448886, '30-07-1980')
go

insert into funcionario
values
(4, 1, 6000, 12345678912),
(5, 2, 3000, 12345668912)
go

insert into compra
values
(100, '30-08-2016', 1),
(200, '30-09-2016', 2),
(300, '30-10-2016', 3)
go

insert into item_compra
values
(1, 1, 1),
(2, 1, 1),
(3, 2, 3),
(4, 2, 3),
(5, 3, 3),
(6, 3, 3),
(1, 3, 3)
go