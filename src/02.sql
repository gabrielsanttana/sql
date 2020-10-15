-- 1

create table motorista (
  codigo int not null,
  nome char(50) not null,
  nro_carteira char(10) not null,
  hora_entrada datetime not null,
  hora_saida datetime not null,
  primary key(codigo)
)
;

create table cliente (
  codigo int not null,
  rg char(12) not null,
  nome char(50) not null,
  endereço char(100) not null,
  primary key(codigo)
)
;

create table veiculo (
  placa char(8) not null,
  marca char(20) not null,
  cor char(20) not null,
  primary key(placa)
)
;

create table ocorrencia (
  codigo int not null,
  end_busca char(100) not null,
  end_entrega char(100) not null,
  data date not null,
  distancia real not null,
  preco money not null,
  pago bit not null,
  cod_motorista int not null,
  cod_cliente int not null,
  placa char(8) not null,
  primary key(codigo),
  foreign key(cod_motorista) references motorista,
  foreign key(cod_cliente) references cliente,
  foreign key(placa) references veiculo
)
;

create index ix_ocorrencia_motorista 
on ocorrencia (cod_motorista)
;

create index ix_ocorrencia_cliente 
on ocorrencia (cod_cliente)
;

create index ix_ocorrencia_placa
on ocorrencia (placa)
;

-- 2

--a)
insert into motorista
values (1, 'Lucas', '0613621681', '09:00:00', '17:00:00');

--b)
insert into cliente
values (1, '94-149-588-1', 'Carlos', 'Rua das Yasuos Feedados');

--c)
insert into veiculo
values ('EDD-4040', 'Volkswagen', 'Preto');

--d)
insert into ocorrencia
values (10, 'Rua das Yasuos Feedados 140 Americana São Paulo', 'Rua da Karmas 990 Salvador Bahia', '2020-01-01', 5.4, 1000.0, 0, 1, 1, 'EDD-4040');

--e)
update ocorrencia
set pago = 1
where codigo = 10;

--f)
update motorista
set hora_saida = '18:00:00'
where codigo = 5;

--g)
delete ocorrencia
where pago = 1
AND data >= '2020-01-01'
AND data <= '2020-01-05';

--h)
delete veiculo
where placa = 'AAA-5555';

--e) 
select * from motorista
where hora_entrada = '06:00:00'
AND hora_saida = '13:00:00';

--j)
select count(*) from ocorrencia
where pago = 1;

--k)
select data, avg(preco) from ocorrencia
group by data;

--l)
select nome from cliente
where pago = 0;

--m) 
select o.placa, m.nome, o.data, o.distancia from ocorrencia o
inner join motorista m
on m.codigo = o.cod_motorista
order by data;

--n)
select c.nome, m.nome, o.data, o.preco from ocorrencia o
inner join motorista m 
on m.codigo = o.cod_motorista
inner join cliente c
on c.codigo = o.cod_cliente
order by o.data, c.nome;