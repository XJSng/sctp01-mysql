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

    // GET ROUTES
    app.get('/customers', async function (req, res) {
        // We want the first element from the array return from connection.execute
        const [customers] = await connection.execute(
            `SELECT * FROM Customers
            JOIN Companies ON Customers.company_id = Companies.company_id;
            `);
        // This [customer] is known as array destructing
        // this is the same as 
        // const customer = await connection.execute("SELECT * FROM customers")[0]
        // Render using Handlebars template
        res.render('customers/index', {
            customers
        });
    });

    // POST ROUTES
    //Create customer form
    app.get("/customers/create", async (req, res) => {
        const [companies] = await connection.execute(`
    SELECT * FROM Companies`)
        res.render('customers/create', {
            companies
        })
    })

    // POST customer form
    app.post("/customers/create", async (req, res) => {
        const { first_name, last_name, rating, company_id } = req.body
        const query = `
        INSERT INTO Customers (first_name, last_name, rating, company_id)
    VALUES ('${first_name}', '${last_name}', ${rating}, ${company_id})
        `
        await connection.execute(query);
    res.redirect('/customers')

    })
    
    // UPDATE ROUTES

    // DELETE ROUTES

    // END OF ROUTES
}
main()

app.listen(3000, () => {
    console.log("server has started")
})