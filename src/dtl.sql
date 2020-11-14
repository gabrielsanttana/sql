-- 1 - DDL

drop table if exists itemvenda, venda, livro, cliente, atendente, pessoa  

create table pessoa(
  codigo int NOT NULL,
  nome char(20) NOT NULL,
  endereco char(30) NOT NULL,
  telefone char(18) NOT NULL,
  primary key (codigo)
)
go

create table cliente(
  codigo int NOT NULL,
  rg char(12) NOT NULL,
  dtnasc date NOT NULL,
  primary key (codigo),
  foreign key (codigo) references pessoa,
  unique (rg)
)
go

create table atendente(
  codigo int NOT NULL,
  salario smallmoney NOT NULL,
  comissao real NOT NULL,
  primary key (codigo),
  foreign key (codigo) references pessoa,
)
go

create table livro(
  codigo int NOT NULL,
  titulo char(50) NOT NULL,
  autor char(50) NOT NULL,
  preco smallmoney NOT NULL,
  qtd_estoque smallint NOT NULL,
  primary key (codigo)
)
go

create table venda(
  codigo int NOT NULL,
  data datetime NOT NULL,
  cod_cli int NOT NULL,
  cod_aten int NOT NULL,
  primary key (codigo),
  foreign key (cod_cli) references cliente,
  foreign key (cod_aten) references atendente
)
go

create table itemvenda(
  cod_venda int not null,
  cod_livro int not null,
  quantidade smallint not null,
  foreign key (cod_venda) references venda,
  foreign key (cod_livro) references livro,
  primary key (cod_venda,cod_livro)
)
go

create index ix_venda_cod_cli
on venda (cod_cli)
go

create index ix_venda_cod_aten
on venda (cod_aten)
go

create index ix_itemvenda_cod_venda
on itemvenda (cod_venda)
go

create index ix_itemvenda_cod_livro
on itemvenda (cod_livro)
go

-- 2 - DTL

-- Cadastrar um cliente 
begin transaction
  insert into pessoa 
  values(1,'João','Rua do Vale Perdido','(19) 93270-7070')
  if @@rowcount > 0 -- Cadastro efetuado com sucesso
    begin
      insert into cliente 
      values (1,'25-685-214-9','1990-01-01')
      if @@rowcount > 0 -- Cadastro efetuado com sucesso
        commit transaction
      else
        rollback transaction
    end
  else
    rollback transaction

-- Cadastrar um atendente
begin transaction
  insert into pessoa 
  values(2,'Maria','Rua da Perda do Vale','(19) 93860-6060')
  if @@rowcount > 0 -- Cadastro efetuado com sucesso
    begin
      insert into atendente 
      values (2,1500,0.1)
      if @@rowcount > 0 -- Cadastro efetuado com sucesso
        commit transaction
      else
        rollback transaction
    end
  else
    rollback transaction

/* Cadastrar uma venda composta por dois livros distintos. Atualizar o estoque de
cada livro vendido. Considere que o cliente, o atendente e os livros já foram
previamente cadastrados. */
begin transaction
  insert into venda 
  values(1,'2020-01-01 10:09:59',1,2)
  if @@rowcount > 0 -- Cadastro efetuado com sucesso
	  begin
      insert into itemvenda 
      values (1,1,3)
			if @@rowcount > 0 -- Operacao efetuada com sucesso
				begin
					update livro 
					set qtd_estoque = qtd_estoque - 3 
					where codigo = 1
					if @@rowcount > 0 -- Operacao efetuada com sucesso
						begin
							insert into itemvenda 
							values (1,2,5)
							if @@rowcount > 0 -- Operacao efetuada com sucesso
								begin
									update livro 
									set qtd_estoque = qtd_estoque - 5
									where codigo = 2
									if @@rowcount > 0 -- Operacao efetuada com sucesso
										commit transaction
									else
										rollback transaction
								end
							else
								rollback transaction
						end
					else
						rollback transaction
				end
			else
				rollback transaction
		end
  else
    rollback transaction


