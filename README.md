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


Product Categories
--

<img width="1920" height="910" alt="image" src="https://github.com/user-attachments/assets/c452f595-2f89-4fbb-b6e2-94bb0e4cb00f" />

This page allows the manager to view, update, delete, and add a new category to store products in. The cashier can only view them.

The data is displayed in an interactive grid. The following information are displayed:
    - View Products column: this has links with a search icon that actually is the ID of each category. When the user clicks on the link, it opens a modal page that allows the manager to view the products in the category and add/update/remove products as needed. The cashier can only view the products. Same rules apply as in the all products page.
    - Title: the title of the category
    - Description: an optional description of the category.

[Screencast_20260622_112727.webm](https://github.com/user-attachments/assets/806953b6-907f-4bd2-b77f-18c579f23de0)

Through the grid, the manager can only update and add a new category. Deleting a category is done through a separate button called "Delete a Category". When the manager clicks on it, a model pops up asking the user to select the category from a dropdown list, and then they have to click a checkbox to be sure that they want to delete the category.<img width="880" height="356" alt="image" src="https://github.com/user-attachments/assets/0294f70e-9486-4c31-a436-39c87ad172fa" />


Notes and business rules:
    - Deleting a category removes all products and their price change history within that category, and then the category itself.
    - Deleting a category is ONLY possible if a product is not in a transaction already. If a product within a category has a transaction associated with it, it cannot be deleted.

[Screencast_20260622_112905.webm](https://github.com/user-attachments/assets/9345a7c7-bdf3-4d71-9571-7eda151876fc)


Price Change History
--

<img width="1920" height="909" alt="image" src="https://github.com/user-attachments/assets/cd114706-00f2-4297-875d-b8f96ce9797f" />

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
<img width="706" height="669" alt="image" src="https://github.com/user-attachments/assets/3085a3bb-83a3-4847-94e0-401bc1b183f0" />


Reports and Analytics Pages
--
<img width="1920" height="618" alt="image" src="https://github.com/user-attachments/assets/98d50c33-8ad2-49ce-828e-196805356a26" />

#### 1. Dashboard Playground
<img width="1920" height="910" alt="image" src="https://github.com/user-attachments/assets/4eca16d1-c3f5-45ee-94e7-722e58cd086f" />

An interactive report featuring the following tables with action buttons for creating charts, pivot tables, and filtering data:

- **Customers**
  - Chart: Number of customers per city
  - Click on chart items to open a modal showing customers in that city

- **Products**
  - Chart 1: Total Products Per Category
  - Chart 2: Value of Each Category
  - Click on chart items to open a modal showing products in that category
  - Modal allows adding, removing, or updating products

- **Transactions**
  - Displays all transactions with full customer names
  - Side summary chart showing:
    - Lowest total amount transaction
    - Highest total amount transaction
    - Average of total amounts
  - Click min/max values to view products in those transactions

- **Transactions and Products**
  - Shows all transactions with associated products
  - Displays: product title, customer name, quantity, line amount, transaction total
  - Side charts:
    - Customer's total quantity purchased
    - Customer's total amount spent
  - Click pie chart slices to view customer's transactions and products

- **Price Change History**
  - Displays: product title, change date, product ID, new unit price
  - "Find Price of a Product on a Date" button to look up historical pricing

[Screencast_20260622_114113.webm](https://github.com/user-attachments/assets/0475b717-9586-4189-9dfe-18d78f8f742b)


#### 2. Customer Count in a Given City
<img width="855" height="289" alt="image" src="https://github.com/user-attachments/assets/bd476d18-03f6-4d80-8c9a-1c488f4b9a81" />

Select a city to view the total number of customers located there.

#### 3. Transaction Count Between Two Dates
<img width="855" height="362" alt="image" src="https://github.com/user-attachments/assets/a32b7b87-c252-4576-91da-6071a73c7738" />

Specify a date range to get the total number of transactions completed.

#### 4. Price of a Product on a Given Date
<img width="855" height="297" alt="image" src="https://github.com/user-attachments/assets/f303c0b3-749c-4af2-ba57-6f2931cbfeca" />

Select a product and date to retrieve its price on that date (defaults to the earliest price if no change occurred on that exact date).

#### 5. Total Quantity of a Product Sold Between Two Dates
<img width="845" height="365" alt="image" src="https://github.com/user-attachments/assets/5f46de55-f4cf-4bbb-8f64-b09e05f03ecf" />

Select a product and date range to find the total quantity sold during that period.

#### 6. Count of Products Per Transaction
<img width="1920" height="902" alt="image" src="https://github.com/user-attachments/assets/8547547a-c360-499f-8575-7172e6cfc3f5" />


###### 6.1. Interactive Report:
- Displays transactions with product count per transaction
- View Products column with icon link to show items in each transaction
- View Customer Info column with icon link to display customer details

###### 6.2. Pie Charts:
- Customer's Total Quantity Purchased
- Customer's Total Amount Spent
[Screencast_20260622_114556.webm](https://github.com/user-attachments/assets/f77d32af-f14e-4109-9391-b5af53a840f2)


Tools pages
--
There are **2 tools pages**:

##### 1. Import from Excel

Allows managers to import product data from an Excel file with the following workflow:

1. Upload an Excel file containing three columns:
   - Product code
   - Product title
   - Unit price

2. Click the import button
3. System attempts to import product data into the products table
4. Any errors are collected and displayed to the manager

**Error Handling:**
The import continues even when errors occur. Errors are logged for the following conditions:

- Product title is empty
- Product code is empty
- Unit price is empty or invalid (negative value)
- Product code is already associated with another product in the products table

##### 2. Add a New Cashier

Allows managers to create new cashier accounts by specifying:
- Username
- Password
