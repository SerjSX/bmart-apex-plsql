# Documentation - BMart
As a project to test my knowledge in APEX, Oracle SQL and PL/SQL, after my internship at LOGOS, I made a system for a simple fictional business need: a small shop, selling products to customers, needs a system that both the manager(s) and the cashier(s) can use. I named the system the same as the shop's business name - BMart.

There are two roles in the system: Manager and Cashier.

The **manager** can:
- View, add, update and delete customers, products and product categories.
- View and add transactions.
- View price change history for products.
- Use the folloiwng analytical and report tools:
    - Find the customer count in a given city.
    - Find the transaction count between two dates.
    - Find the price of a product in a given date.
    - Find the total quantity of a product sold between two dates.
    - View the count of products per transactions.
    - View a dashboard playground giving access to customer, product, transaction, transaction and lines, and price change history data with charts for each and an interactive view of the data allowing different actions on them.
- Add a new cashier account.

The **cashier** can:
- View and add customers and transactions.
- View products, product categories and the price change history for the products.

The APEX application has the following pages:
1. Customers page
2. Open a Transaction page
3. All Transactions page
4. All Products page
5. Product Categories page
6. Price Change History page
7. Report and Analytics pages
8. Tool pages

These pages will be discussed in detail in the below sections.


# Pages
Customers Page
--
<img width="1920" height="913" alt="image" src="https://github.com/user-attachments/assets/8b63e250-9ca5-424f-900c-e76de3ffe1d1" />

Adding a customer requires the following information: First Name, Last Name, City, Street and Phone Number. The primary key ID for a customer is determined by a sequence created that automatically increments the next value and adds into the INSERT command.

Business rule on adding, deleting, and updating customer information: A customer's phone number must be unique; so a cashier/manager cannot add a customer with a phone number that's already associated to another customer. Nor can they update a customer's phone number to another that's already taken.
<img width="629" height="496" alt="image" src="https://github.com/user-attachments/assets/bb421f09-b04d-44c4-9846-a85ab583c23d" />

The data for all customers is displayed in an interactive grid that allows the user to edit and delete a record. Adding a customer through the interactive grid was removed because it's simpler for the cashier to add through a separate report with separate input boxes rather than in a table format.

For convenience, in the all customers table, the primary key of each customer has the title "View Transactions" and the values are links having the icon of a search that, when clicked on, opens a popup modal showing all of the transactions belonging to the customer of the row. The page also has a Products view under the transactions list for the person to see what products exist in a transaction (updates as the user clicks on a row in the transactions list).
<img width="1920" height="915" alt="image" src="https://github.com/user-attachments/assets/f8a588bd-9b6c-4a42-8c8c-307518961999" />

[Screencast_20260622_081203.webm](https://github.com/user-attachments/assets/1341682d-70f2-4336-a169-d9bf32233f3b)


Open a Transaction
--
Opening a new transaction involves three steps:

[Screencast_20260622_081557.webm](https://github.com/user-attachments/assets/863029b6-c16c-457d-910b-0052cb219006)


**1. Selecting a customer and adding optional comments**

<img width="925" height="426" alt="image" src="https://github.com/user-attachments/assets/ccc073dc-55f8-4d78-9e65-0b95be7a7a15" />

The user selects a customer by either choosing the customer from a dropdown list that displays the customer's name and phone number, or the user enters the customer's phone number in the second input box and the system fetches the customer information (if the number is valid) after the user clicks the Start Transaction button.<img width="925" height="426" alt="image" src="https://github.com/user-attachments/assets/da3f7b33-b20d-4636-8700-30cdb9a0a165" />

The user can also add optional comments regarding the transaction.

**2. Adding products**

<img width="928" height="514" alt="image" src="https://github.com/user-attachments/assets/05fc8781-5e29-4f6b-b3f5-684661513499" />

After the user clicks the "Start Transaction" button, another section opens up next to the selecting a customer section. Here the user cna add as many products as needed from the Select a Product dropdown list, and they have to specify the quantity for the selected product. Once the user is sure they will add it to the transaction, they click the "Add a Product" button and the product is added to the table shown in the same section.

Notes:
- The table shown in this section to display the products in the transaction line is an interactive grid. However, the user can only delete a product. If the user needs to update the quantity of the product, they have to by removing the product from the grid, saving and then adding it back by the same quanitty.
- Neither the product's quantity nor the product's total line amount can be updated through the table shown in this section.
- The product's total line amount is determined by the unit price of the product and the quantity.

**3. Transaction Summary**

<img width="796" height="279" alt="image" src="https://github.com/user-attachments/assets/59930659-ad52-4994-b01e-cee2759b08db" />

After the user adds one product, the transaction summary section is shown. This section shows the transaction date, the total amount (sum of the total line amounts of the products) and the count of the products in the transaction.
Additionally, this section has a button called "Finalize Transaction". When the user clicks on this, the entire page refreshes so the user can add a new transaction.

All Transactions
--
<img width="1920" height="916" alt="image" src="https://github.com/user-attachments/assets/8d2ad9fd-7834-4b18-8f0e-4aeb6cad6df7" />

This page allows the manager(s) and cashier(s) to view all of the transactions. Modifying transactions is not possible for accounting purposes.

The page shows the data in an interactive report that allows only viewing the following information about transactions:
- View Customer Info: this column is the replacement of the customer ID column. It is a link having the icon of a person. When the user clicks on it, a modal pops up that shows the information of the customer associated with the selected transaction: first name, last name, phone number, city and street
- Transaction Date
- Total Amount: this is the sum of the transaction lines; not computed on spot, this was already computed as products were being added in the Add a Transaction page.
- Comments: optional comments.
- View Products: this column is the replacement of the transaction ID column. It's a link that has the icon of a list. When the user clicks on it, a modal pops up showing the products associated with that transaction with the following information: The product title, quantity purchased and total line amount.
- Transaction ID: a column that shows the transaction ID as is.

[Screencast_20260622_082025.webm](https://github.com/user-attachments/assets/102ab9bf-f01a-497f-8405-00ce7da2e965)


The interactive report allows the user to perform some actions on the shown data, such as:
    - Modifying which columns to display and in what order.
    - Filtering what rows to view based on conditions on column(s) or row(s).
    - Sorting and aggregating data.
    - Creating charts and pivot tables.
<img width="597" height="636" alt="image" src="https://github.com/user-attachments/assets/ce9286d6-e3cf-49cd-a207-f6b3797789fe" />


All Products
--
<img width="1920" height="913" alt="image" src="https://github.com/user-attachments/assets/a29f696f-9e09-477f-829f-8942bb88cc10" />

This page allows the manager to view, update, delete and add new products. The cashier can only view the list without being able to modify anything.

The data is displayed in an interactive grid. The following information are displayed about each product:
    - The product ID, from the table. This value cannot be modified whatsoever and is given by a sequence on the INSERT command.
    - Title: the title of the product
    - Category: the category that the product belongs under. This can be changed using a dropdown list that shows the available categories.
    - Unit price: can be anything from $0.1 up to $9999.00. This value can be modified and the changes are stored in the price history table which we will see later.
    - Last updated price date: this is the date when the price was updated the most recent. This cannot be modified, it's automatically adjusted when a product is newly added and whenever a price is changed.
    - Description: an optional description for a product. Can be modified.
    - Product Code UK: a unique product code given by the store. This value can be changed, but it cannot be the same code as another product's code. Nor can it be empty.

Actions (creating charts, pivot tables...) cannot be performed on this interactive grid to keep the page minimalistic. The user can use the search bar though to find specific product(s).

[Screencast_20260622_082506.webm](https://github.com/user-attachments/assets/e155122d-2073-4d76-b0da-33afd2379259)


--
Product Categories
--
This page allows the manager to view, update, delete, and add a new category to store products in. The cashier can only view them.

The data is displayed in an interactive grid. The following information are displayed:
    - View Products column: this has links with a search icon that actually is the ID of each category. When the user clicks on the link, it opens a modal page that allows the manager to view the products in the category and add/update/remove products as needed. The cashier can only view the products. Same rules apply as in the all products page.
    - Title: the title of the category
    - Description: an optional description of the category.

Through the grid, the manager can only update and add a new category. Deleting a category is done through a separate button called "Delete a Category". When the manager clicks on it, a model pops up asking the user to select the category from a dropdown list, and then they have to click a checkbox to be sure that they want to delete the category.

Notes and business rules:
    - Deleting a category removes all products and their price change history within that category, and then the category itself.
    - Deleting a category is ONLY possible if a product is not in a transaction already. If a product within a category has a transaction associated with it, it cannot be deleted.

--
Price Change History
--
This page allows the managers and cashiers to view the price change history of products. It shows:
    - Change Date
    - Title of the product
    - Unit price to which it was changed to.

The data is displayed in an interactive report and allows a manager/cashier to do Actions on the shown data, such as:
    - Modifying the columns to hide/display
    - Adding filters both to rows and columns.
    - Creating charts
    - Saving a filter configuration as a report to come back to whenever needed
    - Downloading the report either as PDF or CSV file

--
Reports and Analytics Pages
--
The report and analytics pages consists of 6 pages:
    1. Dashboard playground:
        This page has the following tables in an interactive report format: Customers, Products, Transactions, Transactions and Products (lines), Price Change History.
        It allows the manager to play around with the data and use the Actions button to do different operations on each table, such as creaitng charts, pivot tables, and filtering the data.
        Additionally, each page has some charts shown next to the table report:
            - Customers have a chart showing the numbers of customers per city.
            - Products have two charts:
                1. Total Products Per Category
                1. Value of each category
                When the user clicks on an item in the chart, it opens a modal that shows the products in the clicked category. This popup modal also allows the manager to add/remove/update products.

            - Transactions shows all of the transasctions done with the full name of the customer. Additionally on the side there is a summary chart that shows the lowest total amount transaction, the highest, and the average of the total amounts. When the user clicks on the minimum/maximum, it opens a modal that shows the products in the transaction that has those values.

            - Transaction and Products: this table shows all of the transactions along with the products associated to each transaction. It shows the product's full title, the customer's full name, the quantity bought of the product, the total line amount and the total amount of each transaction. Additionally, there are two charts shown on the side:
                1. The customer's total quantity purchased
                2. The customer's total amount spent
                These two show which customers spent the most, or bought the most products by quantity. When the manager clicks on a slice of the pie chart shown, a modal pops up showing the customer's transasctions list and the products in each transaction (as seen in the Customers page).

            - Price Change History: this table shows each product's change history of their unit price, the full title of the product, the change date, the ID of the product, and the unit price it was changed to. Additionally there's a button called "Find Price of a Product on a Date" that opens a modal, allowing the manager to pick a date and a product to find the price of it (if the product existed at the entered date).

        2. Customer Count in a Given City: allows the manager to pick a city and find out how many clients there are in that city.

        3. Transaction Count Between Two Dates: allows the manager to specify two dates and find the total number of transactions done.

        4. Price of a product in a Given Date: allows the mangaer to speify a product and a date to find the price of that product on that date (if the price wasn't changed at the specified date, it takes the earliest one).

        5. Total Quantity of a Product Sold Between Two Dates: allows the manager to select a product, a start date and an end date, to find out how many of that product has been sold between those 2 dates.

        6. Count of Products Per Transaction: has two parts:
            - An interactive report showing the transactions, products count of each transaction, a View Products column with a list icon link that shows which products are in that transaction, and a View Customer Info column with a person icon link that shows the client's information associated with that transaction.
            - Two pie charts: Customer's Total Quantity Purchased and Customer's Total Amount Spent, same as the ones in the dashboard playground.

--
Tools pages
--
There are two tools pages:
    1. Import from Excel: this was done to meet a very specific need and was not generalized later. The shop has an excel file having three columns: product code, product title, and unit price. The manager uploads the file, clicks the import button, and the system attempts to import the data of the products into a pre-defined table in the PL/SQL program. However, any errors that occur is thrown into a temporary collections table to display afterwards to the manager. These errors are considered (but the import does not stop):
        - The title is empty.
        - The product code is empty.
        - The unit price is empty or invalid (< 0).
        - The product code is already associated with another product in the products table.

    2. Add a New Cashier: this allows the manager to create a new cashier account by specifying the username and the password.

