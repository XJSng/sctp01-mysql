# Dependencies
* express
* dotenv
* mysql2
* hbs
* wax-on

# Setup steps
We need to create a database.

1. Create a new database in MySQL (for out example, we use `crm`)

    ```
    create database crm
    ```

2. In the first line of the `schema.sql` and `data.sql`, type in

    ```
    USE crm
    ```

3. Create the tables and setup initial data with :
```
mysql -u root < schema.sql;
mysql -u root < data.sql;
```


### Object Destructuring
```
let person = {
    firstName: "Paul",
    lastName: "Khor",
}

let {firstName, lastName } = person

```