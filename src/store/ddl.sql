drop table if exists item_compra, compra, endereco, produto, unidade_medida, categoria, cargo, cliente, funcionario, pessoa_fisica, fornecedor, pessoa, fornecedor_produto
go

create table endereco (
  id int not null identity(1,1),
  rua char(40) not null,
  numero int not null,
  bairro char(40) not null,
  cidade char(40) not null,
  estado char(2) not null,
  primary key(id)
)
go

create table pessoa (
  id int not null identity(1,1),
  email char(30) not null,
  id_endereco int not null,
  primary key(id),
  foreign key(id_endereco) references endereco,
  unique(id_endereco)
)
go

create table pessoa_fisica (
  id_pessoa int not null,
  cpf char(11) not null,
  nome char(50) not null
  primary key(id_pessoa),
  foreign key(id_pessoa) references pessoa,
  unique(cpf)
)
go

create table fornecedor (
  id_pessoa int not null,
  cnpj char(18) not null,
  razao_social char(50) not null,
  nome_fantasia char(50) not null,
  primary key(id_pessoa),
  foreign key(id_pessoa) references pessoa,
  unique(cnpj)
)
go

create table unidade_medida (
  id int not null identity(1,1),
  nome char(60) not null,
  abreviacao char(10) not null,
  primary key(id)
)
go

create table categoria (
  id int not null identity(1,1),
  nome char(30) not null,
  descricao varchar(100) not null,
  primary key(id)
)
go

create table produto (
  id int not null identity(1,1),
  nome char(50) not null,
  volume real not null,
  id_unidade_medida int not null,
  id_categoria int not null,
  preco money not null,
  quantidade_estoque int not null,
  codigo_barra char(13) not null,
  primary key(id),
  foreign key(id_unidade_medida) references unidade_medida,
  foreign key(id_categoria) references categoria
)
go

create table fornecedor_produto (
  id_fornecedor int not null,
  id_produto int not null,
  primary key(id_fornecedor, id_produto),
  foreign key(id_fornecedor) references fornecedor,
  foreign key(id_produto) references produto,
)
go

create table cliente (
  id_pessoa int not null,
  rg char(9) not null,
  data_nascimento date not null,
  primary key(id_pessoa),
  foreign key(id_pessoa) references pessoa_fisica,
  unique(rg)
)
go

create table cargo (
  id int not null identity(1,1),
  titulo char(30) not null,
  descricao varchar(100) not null, 
  primary key(id)
)
go

create table funcionario (
  id_pessoa int not null,
  id_cargo int not null,
  salario money not null,
  carteira_trabalho char(11) not null,
  primary key(id_pessoa),
  foreign key(id_pessoa) references pessoa_fisica,
  foreign key(id_cargo) references cargo,
  unique(carteira_trabalho)
)
go

create table compra (
  id int not null identity(1,1),
  valor_total real not null,
  data_compra datetime not null,
  id_cliente int not null,
  primary key(id),
  foreign key(id_cliente) references cliente
)
go

create table item_compra (
  id_produto int not null,
  id_compra int not null,
  quantidade int not null,
  primary key(id_produto, id_compra),
  foreign key(id_produto) references produto,
  foreign key(id_compra) references compra
)
go

create index ix_pessoa_fisica_pessoa
on pessoa_fisica (id_pessoa)
go

create index ix_fornecedor_pessoa
on fornecedor (id_pessoa)
go

create index ix_fornecedor_produto_fornecedor
on fornecedor_produto (id_fornecedor)
go

create index ix_fornecedor_produto_produto
on fornecedor_produto (id_produto)
go

create index ix_cliente_pessoa_fisica
on cliente (id_pessoa)
go

create index ix_funcionario_pessoa
on funcionario (id_pessoa)
go

create index ix_funcionario_cargo
on funcionario (id_cargo)
go

create index ix_produto_unidade_medida
on produto (id_unidade_medida)
go

create index ix_produto_categoria
on produto (id_categoria)
go

create index ix_compra_cliente
on compra (id_cliente)
go

create index ix_item_compra_produto 
on item_compra (id_produto)
go

create index ix_item_compra_compra 
on item_compra (id_compra)
go