create view view_compra
as
select 
pf.nome as 'Nome do cliente',
c.valor_total as 'Valor total',
pr.nome as 'Nome do produto',
ic.quantidade as 'Quantidade',
pr.preco as 'Preço',
c.data_compra as 'Data da compra',
concat(e.rua, ' ', e.numero, ', ', e.bairro, ', ', e.cidade, ' - ', e.estado) as 'Endereço'
from compra c
inner join item_compra ic
on ic.id_compra = c.id
inner join produto pr
on ic.id_produto = pr.id
inner join pessoa_fisica pf
on c.id_cliente = pf.id_pessoa;

create view view_cliente
as
select 
pe.email as 'Email',
pf.nome as 'Nome',
pf.cpf as 'CPF',
cli.rg as 'RG',
cli.data_nascimento as 'Data de nascimento',
concat(e.rua, ' ', e.numero, ', ', e.bairro, ', ', e.cidade, ' - ', e.estado) as 'Endereço'
from pessoa pe 
inner join pessoa_fisica pf
on pe.id = pf.id_pessoa
inner join cliente cli
on pe.id = cli.id_pessoa
inner join endereco e
on pe.id_endereco = e.id;

create view view_fornecedor
as 
select 
pe.email as 'Email',
f.cnpj as 'CNPJ',
f.razao_social as 'Razão social',
f.nome_fantasia as 'Nome fantasia',
concat(e.rua, ' ', e.numero, ', ', e.bairro, ', ', e.cidade, ' - ', e.estado) as 'Endereço'
from pessoa pe
inner join fornecedor f 
on pe.id = f.id_pessoa
inner join endereco e
on pe.id_endereco = e.id;

create view view_funcionario
as 
select 
pe.email as 'Email',
pf.nome as 'Nome',
pf.cpf as 'CPF',
c.titulo as 'Cargo',
f.carteira_trabalho as 'Carteira de trabalho',
f.salario as 'Salário'
from pessoa pe
inner join pessoa_fisica pf
on pe.id = pf.id_pessoa
inner join funcionario f
on pe.id = f.id_pessoa
inner join cargo c
on f.id_cargo = c.id
inner join endereco e
on pe.id_endereco = e.id;

create view view_produto
as
select
p.nome as 'Nome',
p.volume as 'Volume',
p.preco as 'Preço',
p.quantidade_estoque as 'Quantidade em estoque',
p.codigo_barra as 'Código de Barras',
um.nome as 'Unidade de Medida',
ca.nome as 'Categoria'
from produto p 
inner join unidade_medida um
on p.id_unidade_medida = um.id
inner join categoria ca
on p.id_categoria = ca.id;

create procedure cadastrar_fornecedor_e_endereco
@email char(30),
@cnpj char(18),
@razao_social char(50),
@nome_fantasia char(50),
@rua char(40),
@numero int,
@bairro char(40),
@cidade char(40),
@estado char(2),
@id_endereco int = NULL,
@id_pessoa int = NULL OUTPUT
as 
begin transaction
insert into endereco(rua, numero, bairro, cidade, estado)
values (@rua, @numero, @bairro, @cidade, @estado);
SET @id_endereco = SCOPE_IDENTITY()
if @@rowcount > 0 -- Operacao realizada com sucesso
  begin
  insert into pessoa(email, id_endereco)
  values(@email, @id_endereco)
  SET @id_pessoa = SCOPE_IDENTITY()
    if @@rowcount > 0 -- Operacao realizada com sucesso
    begin
    insert into fornecedor(id_pessoa, cnpj, razao_social, nome_fantasia)
    values(@id_pessoa, @cnpj, @razao_social, @nome_fantasia)
        if @@rowcount > 0 -- Operacao realizada com sucesso
      begin
          commit transaction
          return 1
        end
    else
      begin
          rollback transaction
          return 0
      end
    end
  else
    begin
      rollback transaction
      return 0
  end
end
else
  begin
  rollback transaction
  return 0
end

create procedure cadastrar_fornecedor_produto
@id_fornecedor int,
@id_produto int
as
insert into fornecedor_produto(id_fornecedor, id_produto)
values (@id_fornecedor, @id_produto)

create procedure cadastrar_produto
@nome char(50),
@volume real,
@id_unidade_medida int,
@id_categoria int,
@preco money,
@quantidade_estoque int,
@codigo_barra char(13)
as
insert into produto(nome, volume, id_unidade_medida, id_categoria, preco, quantidade_estoque, codigo_barra)
values(@nome, @volume, @id_unidade_medida, @id_categoria, @preco, @quantidade_estoque, @codigo_barra)

create procedure cadastrar_compra
@data_compra datetime,
@id_cliente int,
@id_produto int,
@quantidade int,
@id_compra int = NULL
as
begin transaction
insert into compra(valor_total, data_compra, id_cliente)
values(0,@data_compra,@id_cliente)
SET @id_compra = SCOPE_IDENTITY()
if @@ROWCOUNT > 0
  begin
    insert into item_compra(id_compra, id_produto, quantidade)
  values (@id_compra, @id_produto, @quantidade)
  if @@ROWCOUNT > 0
    begin
      commit transaction
    return 1
      end
  else
    begin
        rollback transaction
      return 0
    end
  end
else
  begin
    rollback transaction
  return 0
  end
go

create procedure cadastrar_item_compra
@id_compra int,
@id_produto int,
@quantidade int
as
insert into item_compra(id_compra, id_produto, quantidade)
values (@id_compra, @id_produto, @quantidade)
go

create procedure cadastrar_categoria
@nome char(30),
@descricao varchar(100)
as
insert into categoria(nome, descricao)
values (@nome, @descricao)
go

create procedure cadastrar_unidade_medida
@nome char(60),
@abreviacao char(10)
as
insert into unidade_medida(nome, abreviacao)
values (@nome, @abreviacao)
go

create procedure cadastrar_cargo
@titulo char(30),
@descricao varchar(100)
as
insert into cargo(titulo, descricao)
values (@titulo, @descricao)
go

create procedure cadastrar_cliente_e_endereco
@email char(30),
@nome char(50),
@cpf char(11),
@rg char(9),
@data_nascimento date,
@rua char(40),
@numero int,
@bairro char(40),
@cidade char(40),
@estado char(2),
@id_endereco int = NULL,
@id_pessoa int = NULL OUTPUT
as 
begin transaction
insert into endereco(rua, numero, bairro, cidade, estado)
values (@rua, @numero, @bairro, @cidade, @estado);
SET @id_endereco = SCOPE_IDENTITY()
if @@rowcount > 0 -- Operacao realizada com sucesso
  begin
    insert into pessoa(email, id_endereco)
    values (@email, @id_endereco)
  SET @id_pessoa = SCOPE_IDENTITY()
    if @@rowcount > 0 -- Operacao realizada com sucesso
      begin  
        insert into pessoa_fisica(id_pessoa, cpf, nome)
        values(@id_pessoa, @cpf, @nome)
        if @@rowcount > 0 -- Operacao realizada com sucesso
          begin
            insert into cliente(id_pessoa, rg, data_nascimento)
            values(@id_pessoa, @rg, @data_nascimento)
            if @@rowcount > 0 -- Operacao realizada com sucesso
              begin
                commit transaction
                return 1
              end
            else
              begin
                rollback transaction
                return 0
              end
          end
        else
          rollback transaction
          return 0
      end
    else
      rollback transaction
      return 0
  end
else
  rollback transaction
  return 0
go

create procedure cadastrar_funcionario_e_endereco
@email char(30),
@nome char(50),
@cpf char(11),
@id_cargo int,
@salario money,
@carteira_trabalho char(11),
@rua char(40),
@numero int,
@bairro char(40),
@cidade char(40),
@estado char(2),
@id_endereco int = NULL,
@id_pessoa int = NULL OUTPUT
as 
begin transaction
insert into endereco(rua, numero, bairro, cidade, estado)
values (@rua,@numero, @bairro, @cidade, @estado);
SET @id_endereco = SCOPE_IDENTITY()
if @@rowcount > 0 -- Operacao realizada com sucesso
  begin
    insert into pessoa(email, id_endereco)
    values (@email, @id_endereco)
  SET @id_pessoa = SCOPE_IDENTITY()
    if @@rowcount > 0 -- Operacao realizada com sucesso
      begin  
        insert into pessoa_fisica(id_pessoa, cpf, nome)
        values(@id_pessoa, @cpf, @nome)
        if @@rowcount > 0 -- Operacao realizada com sucesso
          begin
            insert into funcionario(id_pessoa, id_cargo, salario, carteira_trabalho)
            values(@id_pessoa, @id_cargo, @salario, @carteira_trabalho)
            if @@rowcount > 0 -- Operacao realizada com sucesso
              begin
                commit transaction
                return 1
              end
            else
              begin
                rollback transaction
                return 0
              end
          end
        else
          rollback transaction
          return 0
      end
    else
      rollback transaction
      return 0
  end
else
  rollback transaction
  return 0
go	

create procedure cadastrar_funcionario_como_cliente
@id_pessoa int,
@rg char(9),
@data_nascimento date
as 
insert into cliente(id_pessoa, rg, data_nascimento)
values (@id_pessoa, @rg, @data_nascimento)
go
	  
create procedure cadastrar_cliente_como_funcionario
@id_pessoa int,
@id_cargo int,
@salario money,
@carteira_trabalho char(11)
as 
insert into funcionario(id_pessoa, id_cargo, salario, carteira_trabalho)
values (@id_pessoa, @id_cargo, @salario, @carteira_trabalho)

create trigger trigger
on table for type
as 
begin