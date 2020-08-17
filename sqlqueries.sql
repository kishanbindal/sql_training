{\rtf1\ansi\ansicpg1252\cocoartf2513
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;\f1\fnil\fcharset0 HelveticaNeue-Bold;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs28 \cf0 create table user_details(\
	id serial primary key,\
	email varchar(100) unique not null,\
	first_name varchar(50) not null,\
	last_name varchar(50) not null,\
	password varchar(32) not null,\
	contact_number bigint unique not null,\
	check(char_length(cast(contact_number as varchar)) >= 10),\
	verified boolean default false\
)\
\
create table fellowship_candidate(\
	id serial primary key,\
	first_name varchar(50) not null default current_time,\
	middle_name varchar(50) default null,\
	last_name varchar(50) not null default current_time,\
	email_id varchar(60) unique not null default current_time,\
	hired_city varchar(50) not null default 'Mumbai', \
	degree_course varchar(100) not null default current_time,\
	hired_date date not null default current_date,\
	mobile_number bigint unique not null,\
	check(char_length(cast(mobile_number as varchar)) >= 10),\
	pincode int not null default 0,\
	check(char_length(cast(pincode as varchar)) = 6),\
	hired_lab varchar(50) not null default 'Mumbai',\
	attitude decimal(2,1) not null default 0,\
	communication_remark decimal(2,1) not null default 0,\
	knowledge_remark decimal(2,1) not null default 0,\
	aggregate_remark decimal(2,1) not null default 0,\
	status boolean not null default false,\
	creator_stamp timestamp default current_timestamp,\
	creator_user int,\
	foreign key (creator_user) references user_details("id")\
)\
\
\
create table user_roles(\
	id serial primary key,\
	role_name varchar(50) not null,\
	user_id int not null,\
	foreign key (user_id) references user_details("id")\
)\
\
\
alter table fellowship_candidate\
drop column creator_stamp\
\
alter table fellowship_candidate\
add column creator_timestamp timestamp;\
\
alter table fellowship_candidate\
alter column creator_timestamp set not null,\
alter column creator_timestamp set default current_timestamp;\
\
alter table fellowship_candidate\
Drop constraint fellowship_candidate_mobile_number_check\
\
alter table fellowship_candidate\
add constraint fellowship_candidate_mobile_number_check check(char_length(cast(mobile_number as varchar)) > 9 and char_length(cast(mobile_number as varchar)) < 13)\
\
create table candidate_education_detailed_check(\
	id serial primary key,\
	candidate_id int unique not null,\
	foreign key (candidate_id) references fellowship_candidate("id"),\
	is_verified boolean not null default false,\
	creator_stamp timestamp not null default current_timestamp,\
	creator_user int not null,\
	foreign key (creator_user) references user_details("id")\
)\
\
create table candidate_documents(\
	id serial primary key, \
	candidate_id int not null,\
	foreign key (candidate_id) references fellowship_candidate("id"),\
	doc_type varchar(50) not null default current_time,\
	check (doc_type = 'Aadhaar' or doc_type = 'PAN'),\
	doc_path varchar(50) not null default current_time\
)\
\
create table company(\
	id serial primary key,\
	company_name varchar(50) not null default 'No Name, Please Provide',\
	creator_stamp timestamp not null default current_timestamp,\
	creator_user int not null,\
	foreign key (creator_user) references user_details("id")\
)\
\
create table company_requirement(\
	id serial primary key,\
	company_id int not null,\
	foreign key (company_id) references company("id"),\
	city varchar(50) not null default 'City Not Set, Please Set',\
	requested_month date not null default current_date + interval '4' month,\
	is_doc_verification boolean not null default false,\
	requirement_doc_path varchar(50) not null default 'Set Path',\
	no_of_engg smallint not null default 1\
)\
\
create table candidate_tech_stack_assignment(\
	id serial primary key,\
	requirement_id int not null,\
	foreign key (requirement_id) references company_requirement("id"),\
	candidate_id int unique not null,\
	foreign key (candidate_id) references fellowship_candidate("id"),\
	assign_date date not null default current_date + interval '7' day\
)\
\
create table mentor(\
	id serial primary key,\
	name varchar(50) not null,\
	mentor_type varchar(100) not null default 'set type of mentor',\
	status boolean not null default true,\
	creator_stamp timestamp not null default current_timestamp,\
	creator_user int not null,\
	foreign key (creator_user) references user_details("id")\
)\
\
\
insert into user_details(\
	email,\
	first_name,\
	last_name,\
	password,\
	contact_number,\
	verified\
)\
values(\
	'abcxyz@gmail.com', \
	'abc',\
	'xyz',\
	'abc@123',\
	1234567590,\
	true\
)\
\
\pard\pardeftab560\slleading20\partightenfactor0

\f1\b\fs24 \cf0 \
insert into fellowship_candidate(\
	first_name,\
	last_name,\
	email_id,\
	hired_city,\
	degree_course,\
	hired_date,\
	mobile_number,\
	pincode,\
	hired_lab,\
	attitude,\
	communication_remark,\
	knowledge_remark,\
	aggregate_remark,\
	status,\
	creator_timestamp,\
	creator_user\
)\
\
values(\
	'Kishan',\
	'Bindal',\
	'kishan.bindal@gmail.com',\
	'Bangalore',\
	'B.tech in ME',\
	current_date,\
	9738478938,\
	560037,\
	'Bangalore',\
	3,\
	3,\
	3,\
	4,\
	True,\
	current_timestamp,\
	2\
)\
returning *;
\f0\b0\fs28 \
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0
\cf0 \
insert into fellowship_candidate(\
	first_name,\
	last_name,\
	email_id,\
	hired_city,\
	degree_course,\
	hired_date,\
	mobile_number,\
	pincode,\
	hired_lab,\
	status,\
	creator_user\
)\
\
values(\
	'Karan',\
	'Shiva',\
	'karans@gmail.com',\
	'Bangalore',\
	'B.tech in EEE',\
	current_date,\
	1234562785,\
	560002,\
	'Bangalore',\
	True,\
	3\
)\
returning *;\
\
Join queries : \
select fellowship_candidate.first_name as "First Name",\
		fellowship_candidate.last_name as "Last Name",\
		candidate_tech_stack_assignment.\
from candidate_tech_stack_assignment\
inner join fellowship_candidate on fellowship_candidate.id = candidate_tech_stack_assignment.candidate_id\
\
\'97Complex Sub Queries \
\'97 problem statement : fetch all fellowship_candidates that are hired for company A and job location as Bangalore\
\
select fellowship_candidate.first_name as "First Name",\
	fellowship_candidate.last_name as "Last Name",\
	candidate_tech_stack_assignment.requirement_id,\
	CompAReq.city as "Job Location"\
from candidate_tech_stack_assignment\
inner join fellowship_candidate on fellowship_candidate.id = candidate_tech_stack_assignment.candidate_id\
inner join (select id, city from company_requirement\
where company_id = (select id from company\
where company_name = 'Company A') and city='Bangalore') as CompAReq\
on CompAReq.id = candidate_tech_stack_assignment.requirement_id\
\
\
}