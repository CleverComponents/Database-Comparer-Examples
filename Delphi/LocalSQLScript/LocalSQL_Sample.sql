
Create Table dbc_sample_table (id integer, name varchar(255));

CREATE TABLE FRREPORT(ID INTEGER,
TEMPLATE BLOB,
NAME VARCHAR(255),
TYP INTEGER,
FRVER SMALLINT,
USERNAME VARCHAR(20),
LASTEDIT TIMESTAMP);

insert into dbc_sample_table(id, name)
values(20, 'Name 1');

insert into dbc_sample_table(id, name)
values(35, 'Name 2');
