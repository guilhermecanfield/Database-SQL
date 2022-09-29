-- criando banco de dados para uma Oficina
create database if not exists oficina;

use oficina;

-- criação da tabela clientes
create table costumer(
	id_Costumer int auto_increment primary key,
    first_name varchar(14) not null,
    last_name varchar(40) not null,
    street varchar(50) not null,
    add_number smallint,
    add_information varchar(10),
    cpf char(11),
    constraint unique_cpf unique(cpf)
);

-- criação da tabela staff
create table staff(
	id_staff int auto_increment primary key,
    s_first_name varchar(14) not null,
    s_last_name varchar(40) not null,
    s_street varchar(50) not null,
    s_add_number smallint,
    s_add_information varchar(10),
    position enum('Funilaria', 'Manutenção', 'Interno','Supervisor') not null
);

-- criação da tabela part
create table part(
	id_part int auto_increment primary key,
    p_name varchar(20) not null,
    price float not null,
    stock tinyint default 1
);

-- criação da tabela service
create table service(
	id_service int auto_increment primary key,
    serv_name varchar(30) not null unique,
    cost float,
    constraint non_redundant_service unique(serv_name)
);

-- criação da tabela vehicle
create table vehicle(
	id_vehicle int auto_increment primary key,
    license char(7) not null,
    model varchar(15) not null,
    v_year smallint,
    color varchar(10),
    v_owner int,
    constraint unique_license unique(license),
    constraint vehicle_owner foreign key (v_owner) references costumer(id_Costumer)
);

-- criação da tabela assessment
create table assessment(
	id_assess int auto_increment primary key,
    ass_vehicle int,
    ass_staff int,
    constraint assessed_vehicle foreign key (ass_vehicle) references vehicle(id_vehicle),
    constraint assessment_staff foreign key (ass_staff) references staff(id_staff)
);

-- criação da tabela work order
create table work_order(
	id_wo int auto_increment primary key,
    total_cost float,
    wo_status enum('Aguardando autorização', 'Autorizado', 'Em progresso', 'Completo') default 'Aguardando autorização',
    start_date date not null,
    finish_date date not null,
    from_assessment int,
    constraint wo_assessment foreign key (from_assessment) references assessment(id_assess)
);

-- criação da tabela service in work order
create table service_in_work_order(
	code_service int,
    code_wo int,
    constraint s_in_wo_service foreign key (code_service) references service(id_service),
    constraint s_in_wo_work_order foreign key (code_wo) references work_order(id_wo)
);

-- criação da tabela part in work order
create table part_in_work_order(
	code_part int,
    code_wo int,
    constraint p_in_wo_part foreign key (code_part) references part(id_part),
    constraint p_in_wo_work_order foreign key (code_wo) references work_order(id_wo)
);