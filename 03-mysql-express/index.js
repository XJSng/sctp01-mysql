const express = require('express');
const mysql2 = require('mysql2/promise');
const dotenv = require('dotenv');
const wax = require('wax-on')
const hbs = require('hbs')
dotenv.config();

const app = express();
app.use(express.urlencoded());

// Set up Handlebars
app.set('view engine', 'hbs');


// Use Wax-On for additional Handlebars helpers
wax.on(hbs.handlebars);
wax.setLayoutPath('./views/layouts');


async function main() {

    // create a MySQL connection
    const connection = await mysql2.createConnection({
        host: process.env.DB_HOST, // server: URL
        // Root is the user
        user: process.env.DB_USER,
        database: process.env.DB_DATABASE,
        password: process.env.DB_PASSWORD


    })


    app.get('/customers', async function(req, res) {
        const [customers] = await connection.execute("SELECT * FROM Customers")
        // This [customer] is known as array destructing
        // this is the same as 
        // const custmer = await connection.execute("SELECT * FROM customers")[0]
        

        // Render using Handlebars template
        res.render('customers/index', {
            customers
        });
    });

    app.get("/customers/create", async function(req, req){
        res.render('customers/create')
    })
}
main()

app.listen(3000, ()=>{
    console.log("server has started")
})