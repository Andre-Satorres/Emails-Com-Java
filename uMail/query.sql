create table Seguranca
(
	id int primary key,
	nome char (3)
)

create table email
(
   usuario varchar(50) primary key,
   senha   varchar(30) not null,
   porta   int not null,
   seguranca  int not null,
   host int not null,
   constraint fkSeguranca foreign key(seguranca) references Seguranca(id),
)

alter table email drop constraint pkEmail 
alter table email add constraint pkemail primary key (usuario)  

alter table email add nome varchar(20) not null
alter table email add sobrenome varchar(50) not null

create table  host
(
  id int primary key,
  nome varchar(4) not null
)

insert into host values(1, 'imap')
insert into host values(2, 'pop3')
insert into host values(3, 'smtp')

select * from host

insert into Seguranca values(1, 'tls')
insert into Seguranca values(2, 'ssl')

select * from Seguranca

select * from email