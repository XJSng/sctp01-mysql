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