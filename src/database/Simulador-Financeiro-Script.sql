create database simulador_financeiro;
use simulador_financeiro;

create table usuario (
id_usuario int primary key auto_increment, 
nome varchar(100) not null,
cpf char(11) unique not null,
dt_nascimento date not null,
email varchar(70) unique not null,
senha varchar (255)not null,
dt_criacao timestamp default current_timestamp);

create table telefone (
id_telefone int primary key auto_increment,
id_usuario int not null,
ddd char(4) not null,
numero varchar(11) not null,
tipo varchar (20) not null,

constraint cTipo check(tipo in('celular', 'trabalho', 'fixo')),

constraint fk_usuario_telefone
	foreign key (id_usuario)
    references usuario(id_usuario)
    on delete cascade);

create table conta (
id_conta int primary key auto_increment,
id_usuario int not null,
saldo decimal (15,2)not null default 0.00,
dt_criacao timestamp default current_timestamp,
tipo varchar(20)not null,

constraint cTipoConta check(tipo in('corrente', 'poupanca')),

constraint cSaldoPositivoConta check(saldo >=0),

constraint fk_usuario_conta 
	foreign key (id_usuario)
		references usuario(id_usuario)
			on delete cascade
);

create table transferencia (
id_transferencia int primary key auto_increment,
id_conta_origem int not null,
id_conta_destino int not null,
valor decimal (15,2) not null,
tipo varchar (20) not null,
dt_transacao timestamp default current_timestamp,

constraint cValor check(valor >0),

constraint fk_conta_origem
	foreign key (id_conta_origem)
    references conta (id_conta),
    
constraint cNaoAutoTransf check(id_conta_origem <> id_conta_destino)
);





