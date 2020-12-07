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
on c.id_cliente = pf.id_pessoa
go

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
on pe.id_endereco = e.id
go

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
on pe.id_endereco = e.id
go

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
on pe.id_endereco = e.id
go

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
on p.id_categoria = ca.id
go