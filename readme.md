To start mysql, in the terminal, type in `mysql -u root`

# Create a new database user
In the MySQL CLI:
```
CREATE USER 'ahkow'@'localhost' IDENTIFIED BY 'rotiprata123';
```

```
GRANT ALL PRIVILEGES on sakila.* TO 'ahkow'@'localhost' WITH GRANT OPTION;
```
**Note:** Replace *sakila* with the name of the database you want the user to have access to
 
 ```
FLUSH PRIVILEGES;
```


# Show databases;
show databases;

# create database <name of database>;
create database swimming_coach;

# move to database
use swiming_coach;

# see current database
select database();

# create a table
## order of the creating the columns
## <name of column> <data type> <options> <null or not null>,
create table parents (
id int unsigned auto_increment primary key,
name varchar(100) not null,
email varchar(320) not null,
phone varchar(20) not null
) engine = innodb;

## show all the tables in a database
show tables;

## to examine a table
describe parents;

### creating the student table next
2 ways of doing foreign key
1. Create the table first, then add the foreign KEY
2. Create the table and the foreign key in one DDL statement

create table students (
id mediumint unsigned auto_increment primary key,
name varchar(300) not null,
swimming_grade varchar(20) not null,
dob datetime not null,
## MAKE SURE THE DATA TYPE OF THE FK MATCHES THE CORRESPONDING COLUMN IN THE OTHER TABLE
parent_id int unsigned not null
) engine = innodb;
- engine must be innodb;

## The step to Create the foreign key between two tables 
-- Add constraint: Name a FK
alter table students add constraint fk_students_parents
foreign key (parent_id) references parents(id);
- `fk_students_parents` is the name of the relationship

### Inserting data (DML)
insert into parents (name, email, phone) values ("Tan Ah Kow", "tanahkow@gemail.com", "12341234");

### Get all rows from table (DQL)
select `*` from `parents`;

### Inserting multiple rows
insert into parents (name, email, phone) values ("Tan Ah Mew", "tanahmew@gemail.com", "90438392"), ("Charlie Brown", "charliebrown@gemail.com", "09876543");

-- insert student
insert into students (name, swimming_grade, dob, parent_id) values ("Tan Ah Bao", "Bronze", "2020-05-10", 1);

-- delete error because one student is referencing a parent with _id 1
delete from parents where id = 1

### Create sessions table
create table sessions (
    id int unsigned auto_increment primary key,
    amount int unsigned not null, 
    type varchar(20) default "cash"
) engine = innodb;

## Adding in a foreign key after creating the table
alter table sessions add column student_id mediumint unsigned not null;
alter table sessions add constraint fk_sessions_students foreign key (student_id) references students(id)

## How to delete a column
drop table <name of table>
alter table students drop column student_id

## Update an existing row
update parents set name="John Snow" where id = 2;

## Update multiple rows
update parents set email="johnsnow@gemail.com", phone="91791290" where id = 2;
View via this code `select * from parents`

## Delete a dow
delete from parents where id=3;

## Adding back charlie brown will result in an id of 4
insert into parents (name, email, phone) values ("Charlie Brown", "charliebrown@gemail.com", "09876543");

### Creating table, the foreign key plus reference relationship
create table sessions (
    id int unsigned auto_increment primary key,
    description varchar(255) not null,
    
)