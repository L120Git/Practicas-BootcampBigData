create schema LauraCastaño_BD_SQL authorization woeapgje



--tabla grupo-empresarial

create table LauraCastaño_BD_SQL.grupo_empresarial(
	id_grupo_empresarial varchar(20) not null, --PK
	nombre_grupo varchar(100) not null,
	description varchar(512) null
);

alter table LauraCastaño_BD_SQL.grupo_empresarial
add constraint grupo_PK primary key (id_grupo_empresarial);

--Insetar datos de Grupo_Empresarial

insert into LauraCastaño_BD_SQL.grupo_empresarial (id_grupo_empresarial, nombre_grupo, description) values('1','VAG','');
insert into LauraCastaño_BD_SQL.grupo_empresarial (id_grupo_empresarial, nombre_grupo, description) values('2','BMW GROUP','');
insert into LauraCastaño_BD_SQL.grupo_empresarial (id_grupo_empresarial, nombre_grupo, description) values('3','DAIMER','');
insert into LauraCastaño_BD_SQL.grupo_empresarial (id_grupo_empresarial, nombre_grupo, description) values('4','GRUPO FCA','');
insert into LauraCastaño_BD_SQL.grupo_empresarial (id_grupo_empresarial, nombre_grupo, description) values('5','TESLA','');
insert into LauraCastaño_BD_SQL.grupo_empresarial (id_grupo_empresarial, nombre_grupo, description) values('6','HYUNDAI','');
insert into LauraCastaño_BD_SQL.grupo_empresarial (id_grupo_empresarial, nombre_grupo, description) values('7','FORD','');
insert into LauraCastaño_BD_SQL.grupo_empresarial (id_grupo_empresarial, nombre_grupo, description) values('8','GRUPO GEELY','');
insert into LauraCastaño_BD_SQL.grupo_empresarial (id_grupo_empresarial, nombre_grupo, description) values('9','HONDA','');
insert into LauraCastaño_BD_SQL.grupo_empresarial (id_grupo_empresarial, nombre_grupo, description) values('10','KIA MOTORS','');
insert into LauraCastaño_BD_SQL.grupo_empresarial (id_grupo_empresarial, nombre_grupo, description) values('11','RENAULT-NISSAN','');
insert into LauraCastaño_BD_SQL.grupo_empresarial (id_grupo_empresarial, nombre_grupo, description) values('12','MAZDA MOTORS','');



--tabla marcas

create table LauraCastaño_BD_SQL.marcas(
	id_marca varchar(20) not null, --PK
	id_grupo_empresarial varchar(100), --FK grupo_empresarial()
	nombre_marca varchar(100) not null
);

alter table LauraCastaño_BD_SQL.marcas
add constraint marcas_PK primary key (id_marca);

alter table LauraCastaño_BD_SQL.marcas
add constraint marcas_grupo_FK foreign key (id_grupo_empresarial)
references LauraCastaño_BD_SQL.grupo_empresarial (id_grupo_empresarial);

--insertar datos de marcas

insert into LauraCastaño_BD_SQL.marcas (id_marca, id_grupo_empresarial,nombre_marca) values ('1','1','AUDI');
insert into LauraCastaño_BD_SQL.marcas (id_marca, id_grupo_empresarial,nombre_marca) values ('2','2','MINI');
insert into LauraCastaño_BD_SQL.marcas (id_marca, id_grupo_empresarial,nombre_marca) values ('3','12','MAZDA');
insert into LauraCastaño_BD_SQL.marcas (id_marca, id_grupo_empresarial,nombre_marca) values ('4','3','MERCEDES BENZ');
insert into LauraCastaño_BD_SQL.marcas (id_marca, id_grupo_empresarial,nombre_marca) values ('5','10','KIA');
insert into LauraCastaño_BD_SQL.marcas (id_marca, id_grupo_empresarial,nombre_marca) values ('6','11','INFINITY');
insert into LauraCastaño_BD_SQL.marcas (id_marca, id_grupo_empresarial,nombre_marca) values ('7','1','VOLKSWAGEN');
insert into LauraCastaño_BD_SQL.marcas (id_marca, id_grupo_empresarial,nombre_marca) values ('8','1','SEAT');
insert into LauraCastaño_BD_SQL.marcas (id_marca, id_grupo_empresarial,nombre_marca) values ('9','11','NISSAN');
insert into LauraCastaño_BD_SQL.marcas (id_marca, id_grupo_empresarial,nombre_marca) values ('10','5','TESLA');
insert into LauraCastaño_BD_SQL.marcas (id_marca, id_grupo_empresarial,nombre_marca) values ('11','11','DACIA');
insert into LauraCastaño_BD_SQL.marcas (id_marca, id_grupo_empresarial,nombre_marca) values ('12','4','JEEP');
insert into LauraCastaño_BD_SQL.marcas (id_marca, id_grupo_empresarial,nombre_marca) values ('13','2','BMW');



-- Tabla modelos

create table LauraCastaño_BD_SQL.modelos(
	id_modelo varchar(50) not null, --PK
	nombre varchar(100) not null,
	id_marca varchar(20) not null, --FK marcas()
	description varchar(512) null
);

alter table LauraCastaño_BD_SQL.modelos
add constraint modelos_PK primary key (id_modelo);

alter table LauraCastaño_BD_SQL.modelos
add constraint modelos_marcas_FK foreign key (id_marca)
references LauraCastaño_BD_SQL.marcas (id_marca);

--insertar datos modelos

insert into LauraCastaño_BD_SQL.modelos (id_modelo, nombre, id_marca) values ('1','Q5','1');
insert into LauraCastaño_BD_SQL.modelos (id_modelo, nombre, id_marca) values ('2','SERIE8 CC','13');
insert into LauraCastaño_BD_SQL.modelos (id_modelo, nombre, id_marca) values ('3','CX3','3');
insert into LauraCastaño_BD_SQL.modelos (id_modelo, nombre, id_marca) values ('4','A180','4');
insert into LauraCastaño_BD_SQL.modelos (id_modelo, nombre, id_marca) values ('5','QASHQAI','9');
insert into LauraCastaño_BD_SQL.modelos (id_modelo, nombre, id_marca) values ('6','LEON','8');
insert into LauraCastaño_BD_SQL.modelos (id_modelo, nombre, id_marca) values ('7','SANDERO', '11');
insert into LauraCastaño_BD_SQL.modelos (id_modelo, nombre, id_marca) values ('8','GOLF','7');
insert into LauraCastaño_BD_SQL.modelos (id_modelo, nombre, id_marca) values ('9','IBIZA','8');
insert into LauraCastaño_BD_SQL.modelos (id_modelo, nombre, id_marca) values ('10','GLA 220','4');
insert into LauraCastaño_BD_SQL.modelos (id_modelo, nombre, id_marca) values ('11','POLO','7');
insert into LauraCastaño_BD_SQL.modelos (id_modelo, nombre, id_marca) values ('12','QX55','13');
insert into LauraCastaño_BD_SQL.modelos (id_modelo, nombre, id_marca) values ('13','MODEL 3','10');
insert into LauraCastaño_BD_SQL.modelos (id_modelo, nombre, id_marca) values ('14','STONIC','5');
insert into LauraCastaño_BD_SQL.modelos (id_modelo, nombre, id_marca) values ('15','ARONA','8');
insert into LauraCastaño_BD_SQL.modelos (id_modelo, nombre, id_marca) values ('16','COMPASS','6');
insert into LauraCastaño_BD_SQL.modelos (id_modelo, nombre, id_marca) values ('17','SERIE 3 ','13');
insert into LauraCastaño_BD_SQL.modelos (id_modelo, nombre, id_marca) values ('18','A3','1');



--tabla aseguradoras 

create table LauraCastaño_BD_SQL.aseguradoras(
	id_aseguradora varchar(20) not null, --PK
	nombre_aseguradora varchar (100) not null,
	description varchar(512) null
);

alter table LauraCastaño_BD_SQL.aseguradoras
add constraint aseguradoras_PK primary key (id_aseguradora);

--insertar datos aseguradoras 

insert into LauraCastaño_BD_SQL.aseguradoras (id_aseguradora, nombre_aseguradora, description) values('1','MAPHRE','');
insert into LauraCastaño_BD_SQL.aseguradoras (id_aseguradora, nombre_aseguradora, description) values('2','LINEA DIRECTA','');
insert into LauraCastaño_BD_SQL.aseguradoras (id_aseguradora, nombre_aseguradora, description) values('3','MUTUA MADRILEÑA','');
insert into LauraCastaño_BD_SQL.aseguradoras (id_aseguradora, nombre_aseguradora, description) values('4','LIBERTY','');
insert into LauraCastaño_BD_SQL.aseguradoras (id_aseguradora, nombre_aseguradora, description) values('5','PENELOPE','');
insert into LauraCastaño_BD_SQL.aseguradoras (id_aseguradora, nombre_aseguradora, description) values('6','CATALANA OCCIDENTE','');
insert into LauraCastaño_BD_SQL.aseguradoras (id_aseguradora, nombre_aseguradora, description) values('7','AXA','');
insert into LauraCastaño_BD_SQL.aseguradoras (id_aseguradora, nombre_aseguradora, description) values('8','GENERALI','');
insert into LauraCastaño_BD_SQL.aseguradoras (id_aseguradora, nombre_aseguradora, description) values('9','ALLIANZ','');



-- Tabla color-coches

create table LauraCastaño_BD_SQL.color_coches(
	id_color varchar(50) not null, --PK
	nombre varchar(100) not null, 
	description varchar(512) null
);

alter table LauraCastaño_BD_SQL.color_coches
add constraint color_coches_PK primary key (id_color);

--insertar datos en color_coches

insert into LauraCastaño_BD_SQL.color_coches (id_color, nombre) values ('1','azul hielo');
insert into LauraCastaño_BD_SQL.color_coches (id_color, nombre) values ('2','rojo ultimate');
insert into LauraCastaño_BD_SQL.color_coches (id_color, nombre) values ('3','verde oliva');
insert into LauraCastaño_BD_SQL.color_coches (id_color, nombre) values ('4','amarillo faro');
insert into LauraCastaño_BD_SQL.color_coches (id_color, nombre) values ('5','azul vertigo');
insert into LauraCastaño_BD_SQL.color_coches (id_color, nombre) values ('6','negro perla');
insert into LauraCastaño_BD_SQL.color_coches (id_color, nombre) values ('7','blanco hielo');
insert into LauraCastaño_BD_SQL.color_coches (id_color, nombre) values ('8','gris artense');
insert into LauraCastaño_BD_SQL.color_coches (id_color, nombre) values ('9','rojo elixir');
insert into LauraCastaño_BD_SQL.color_coches (id_color, nombre) values ('10','blanco banquise');
insert into LauraCastaño_BD_SQL.color_coches (id_color, nombre) values ('11','blanco nacarado');
insert into LauraCastaño_BD_SQL.color_coches (id_color, nombre) values ('12','orange fushion');
insert into LauraCastaño_BD_SQL.color_coches (id_color, nombre) values ('13','gris perla');
insert into LauraCastaño_BD_SQL.color_coches (id_color, nombre) values ('14','azul ultramar');
insert into LauraCastaño_BD_SQL.color_coches (id_color, nombre) values ('15','gris platino');
insert into LauraCastaño_BD_SQL.color_coches (id_color, nombre) values ('16','blanco perla');



--Tabla coches

create table LauraCastaño_BD_SQL.coches(
	id_coche varchar(20) not null, --PK
	id_modelo varchar(100) not null, --FK modelos()
	fecha_compra date not null default '4000-01-01', 
	matricula varchar (50) not null,
	id_color varchar(50) not null, --FK color_coches()
	total_kms integer not null,
	id_aseguradora varchar(20) not null, 
	num_poliza varchar (50) not null,
	conductor_habitual varchar(100) not null default 'Varios'	
);


alter table LauraCastaño_BD_SQL.coches
add constraint coches_PK primary key (id_coche);

alter table LauraCastaño_BD_SQL.coches
add constraint coches_modelos_FK foreign key (id_modelo)
references LauraCastaño_BD_SQL.modelos (id_modelo);

alter table LauraCastaño_BD_SQL.coches
add constraint coches_color_FK foreign key (id_color)
references LauraCastaño_BD_SQL.color_coches (id_color);  

alter table LauraCastaño_BD_SQL.coches
add constraint coches_aseguradora_FK foreign key (id_aseguradora)
references LauraCastaño_BD_SQL.aseguradoras (id_aseguradora);

--insertar datos en coches

insert into LauraCastaño_BD_SQL.coches(id_coche,id_modelo, fecha_compra, matricula, id_color,total_kms, id_aseguradora, num_poliza, conductor_habitual) values ('1','1','2017/01/06','2898CLX','12','143350','1','43/287543','Maria Gimenez');
insert into LauraCastaño_BD_SQL.coches(id_coche,id_modelo, fecha_compra, matricula, id_color,total_kms, id_aseguradora, num_poliza, conductor_habitual) values ('2','2','2017/01/06','2394LRX','8','13820','3','43/730467','Sandra Poveda');
insert into LauraCastaño_BD_SQL.coches(id_coche,id_modelo, fecha_compra, matricula, id_color,total_kms, id_aseguradora, num_poliza, conductor_habitual) values ('3','3','2017/01/06','0923CJS','2','38670','5','23/114528','Andres Sandoval');
insert into LauraCastaño_BD_SQL.coches(id_coche,id_modelo, fecha_compra, matricula, id_color,total_kms, id_aseguradora, num_poliza, conductor_habitual) values ('4','4','2017/01/06','2789FKJ','3','45300','7','14/123456','');
insert into LauraCastaño_BD_SQL.coches(id_coche,id_modelo, fecha_compra, matricula, id_color,total_kms, id_aseguradora, num_poliza, conductor_habitual) values ('5','5','2017/01/06','6163JJS','10','32610','9','23/876543','Leonor Vazquez');
insert into LauraCastaño_BD_SQL.coches(id_coche,id_modelo, fecha_compra, matricula, id_color,total_kms, id_aseguradora, num_poliza, conductor_habitual) values ('6','6','2017/01/06','0413ERM','11','145680','7','53/843285','');
insert into LauraCastaño_BD_SQL.coches(id_coche,id_modelo, fecha_compra, matricula, id_color,total_kms, id_aseguradora, num_poliza, conductor_habitual) values ('7','7','2017/01/06','4553MTR','16','18100','4','43/823756','');
insert into LauraCastaño_BD_SQL.coches(id_coche,id_modelo, fecha_compra, matricula, id_color,total_kms, id_aseguradora, num_poliza, conductor_habitual) values ('8','8','2017/01/06','8732EHS','2','125600','9','23/987653','Jesus Romero');
insert into LauraCastaño_BD_SQL.coches(id_coche,id_modelo, fecha_compra, matricula, id_color,total_kms, id_aseguradora, num_poliza, conductor_habitual) values ('9','9','2017/01/06','8056DAS','13','151000','1','14/982345','Maria Jesus Losa');
insert into LauraCastaño_BD_SQL.coches(id_coche,id_modelo, fecha_compra, matricula, id_color,total_kms, id_aseguradora, num_poliza, conductor_habitual) values ('10','10','2017/01/06','7324CMS','11','175980','2','23/984235','');
insert into LauraCastaño_BD_SQL.coches(id_coche,id_modelo, fecha_compra, matricula, id_color,total_kms, id_aseguradora, num_poliza, conductor_habitual) values ('11','11','2017/01/06','6781MNR','7','13257','2','50/973578','Andrea Hernan');
insert into LauraCastaño_BD_SQL.coches(id_coche,id_modelo, fecha_compra, matricula, id_color,total_kms, id_aseguradora, num_poliza, conductor_habitual) values ('12','12','2017/01/06','1205LAT','2','17201','3','43/843571','Jorge Lorenzo');
insert into LauraCastaño_BD_SQL.coches(id_coche,id_modelo, fecha_compra, matricula, id_color,total_kms, id_aseguradora, num_poliza, conductor_habitual) values ('13','13','2017/01/06','3489KLS','10','26802','6','23/1287654','Ismael Sanz');
insert into LauraCastaño_BD_SQL.coches(id_coche,id_modelo, fecha_compra, matricula, id_color,total_kms, id_aseguradora, num_poliza, conductor_habitual) values ('14','14','2017/01/06','5689KKP','7','135680','8','43/9834573','');
insert into LauraCastaño_BD_SQL.coches(id_coche,id_modelo, fecha_compra, matricula, id_color,total_kms, id_aseguradora, num_poliza, conductor_habitual) values ('15','15','2017/01/06','2397DMW','2','113070','2','12/8754356','Alicia Pet');
insert into LauraCastaño_BD_SQL.coches(id_coche,id_modelo, fecha_compra, matricula, id_color,total_kms, id_aseguradora, num_poliza, conductor_habitual) values ('16','16','2017/01/06','1711LCP','13','3584','6','23/874325','');
insert into LauraCastaño_BD_SQL.coches(id_coche,id_modelo, fecha_compra, matricula, id_color,total_kms, id_aseguradora, num_poliza, conductor_habitual) values ('17','17','2017/01/06','3467DCA','3','120540','8','23/876432','Luisa Gala');
insert into LauraCastaño_BD_SQL.coches(id_coche,id_modelo, fecha_compra, matricula, id_color,total_kms, id_aseguradora, num_poliza, conductor_habitual) values ('18','18','2017/01/06','2790EEH','7','158400','9','12/865290','');



--tabla monedas

create table LauraCastaño_BD_SQL.monedas(
	id_moneda varchar(20) not null, --PK
	nombre varchar (50) not null
);

alter table LauraCastaño_BD_SQL.monedas
add constraint monedas_PK primary key (id_moneda);

--Insetar datos de monedas

insert into LauraCastaño_BD_SQL.monedas (id_moneda, nombre)
values ('1','EUR');
insert into LauraCastaño_BD_SQL.monedas (id_moneda, nombre)
values ('2','USD');
insert into LauraCastaño_BD_SQL.monedas (id_moneda, nombre)
values ('3','JPY');
insert into LauraCastaño_BD_SQL.monedas (id_moneda, nombre)
values ('4','GBP');
insert into LauraCastaño_BD_SQL.monedas (id_moneda, nombre)
values ('5','AUD');
insert into LauraCastaño_BD_SQL.monedas (id_moneda, nombre)
values ('6','CAD');
insert into LauraCastaño_BD_SQL.monedas (id_moneda, nombre)
values ('7','CHF');
insert into LauraCastaño_BD_SQL.monedas (id_moneda, nombre)
values ('8','CNH');
insert into LauraCastaño_BD_SQL.monedas (id_moneda, nombre)
values ('9','HKD');
insert into LauraCastaño_BD_SQL.monedas (id_moneda, nombre)
values ('10','NZD');


--tabla revisiones-coches 

create table LauraCastaño_BD_SQL.revisiones_coches(
	id_coche varchar(20) not null, --PK,FK coches()
	id_revision varchar(20) not null, --PK
	fecha_revision date not null default '4000-01-01',
	kms_ultima_revision varchar(50) not null default '0000',
	precio_revision decimal(20) not null default '0000',
	id_moneda varchar(20) not null default '1', --FK monedas()
	notas varchar(512) null
);

alter table LauraCastaño_BD_SQL.revisiones_coches
add constraint revisiones_PK primary key (id_coche,id_revision);

alter table LauraCastaño_BD_SQL.revisiones_coches
add constraint revisiones_coches_FK foreign key (id_coche)
references LauraCastaño_BD_SQL.coches(id_coche);

alter table LauraCastaño_BD_SQL.revisiones_coches 
add constraint revisiones_moneda_FK foreign key (id_moneda)
references LauraCastaño_BD_SQL.monedas (id_moneda);

--insertar datos revisiones_coches

insert into LauraCastaño_BD_SQL.revisiones_coches (id_revision, id_coche, fecha_revision, kms_ultima_revision, precio_revision, id_moneda, notas) values('1','1','2022-02-02','47000','54.00','1','falta filtro aire');
insert into LauraCastaño_BD_SQL.revisiones_coches (id_revision, id_coche, fecha_revision, kms_ultima_revision, precio_revision, id_moneda, notas) values('2','11','4000-01-01','','0','1','');
insert into LauraCastaño_BD_SQL.revisiones_coches (id_revision, id_coche, fecha_revision, kms_ultima_revision, precio_revision, id_moneda, notas) values('3','2','2022-02-02','97000','45.3','1','');
insert into LauraCastaño_BD_SQL.revisiones_coches (id_revision, id_coche, fecha_revision, kms_ultima_revision, precio_revision, id_moneda, notas) values('4','12','4000-01-01','','0','1','');
insert into LauraCastaño_BD_SQL.revisiones_coches (id_revision, id_coche, fecha_revision, kms_ultima_revision, precio_revision, id_moneda, notas) values('5','3','2022-03-04','145000','32.23','1','correa distribucion');
insert into LauraCastaño_BD_SQL.revisiones_coches (id_revision, id_coche, fecha_revision, kms_ultima_revision, precio_revision, id_moneda, notas) values('6','13','4000-01-01','','0','1','');
insert into LauraCastaño_BD_SQL.revisiones_coches (id_revision, id_coche, fecha_revision, kms_ultima_revision, precio_revision, id_moneda, notas) values('7','4','2022-05-08','147000','37.3','1','correa distribucion');
insert into LauraCastaño_BD_SQL.revisiones_coches (id_revision, id_coche, fecha_revision, kms_ultima_revision, precio_revision, id_moneda, notas) values('8','14','2022-05-08','153000','36.1','1','correa distribucion');
insert into LauraCastaño_BD_SQL.revisiones_coches (id_revision, id_coche, fecha_revision, kms_ultima_revision, precio_revision, id_moneda, notas) values('9','5','2021-12-17','52000','43.12','1','falta filtro aire');
insert into LauraCastaño_BD_SQL.revisiones_coches (id_revision, id_coche, fecha_revision, kms_ultima_revision, precio_revision, id_moneda, notas) values('10','15','2021-12-17','48000','48.00','1','falta filtro aire');
insert into LauraCastaño_BD_SQL.revisiones_coches (id_revision, id_coche, fecha_revision, kms_ultima_revision, precio_revision, id_moneda, notas) values('11','6','2022-03-04','102000','34.5','1','');
insert into LauraCastaño_BD_SQL.revisiones_coches (id_revision, id_coche, fecha_revision, kms_ultima_revision, precio_revision, id_moneda, notas) values('12','16','2022-04-03','100230','0','1','');
insert into LauraCastaño_BD_SQL.revisiones_coches (id_revision, id_coche, fecha_revision, kms_ultima_revision, precio_revision, id_moneda, notas) values('13','7','2022-08-05','110500','32.12','1','');
insert into LauraCastaño_BD_SQL.revisiones_coches (id_revision, id_coche, fecha_revision, kms_ultima_revision, precio_revision, id_moneda, notas) values('14','17','2021-12-17','96450','33.6','1','');
insert into LauraCastaño_BD_SQL.revisiones_coches (id_revision, id_coche, fecha_revision, kms_ultima_revision, precio_revision, id_moneda, notas) values('15','8','4000-01-01','','0','1','');
insert into LauraCastaño_BD_SQL.revisiones_coches (id_revision, id_coche, fecha_revision, kms_ultima_revision, precio_revision, id_moneda, notas) values('16','18','4000-01-01','','0','1','');
insert into LauraCastaño_BD_SQL.revisiones_coches (id_revision, id_coche, fecha_revision, kms_ultima_revision, precio_revision, id_moneda, notas) values('17','9','2022-02-02','104000','37.00','1','');
insert into LauraCastaño_BD_SQL.revisiones_coches (id_revision, id_coche, fecha_revision, kms_ultima_revision, precio_revision, id_moneda, notas) values('18','10','2022-03-04','102007','39.00','1','');

