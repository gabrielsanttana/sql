create view view_compra
as
select 
pf.nome as 'Nome',
c.valor_total as 'Valor Total',
pr.nome as 'Nome do Produto',
ic.quantidade as 'Quantidade',
pr.preco as 'Preço',
c.data_compra as 'Data Compra'
from compra c
inner join item_compra ic
on ic.id_compra = c.id
inner join produto pr
on ic.id_produto = pr.id
inner join pessoa_fisica pf
on c.id_cliente = pf.id_pessoa;

create procedure procedure
@
@
@
as
begin transaction

create trigger trigger
on table for type
as 
begin