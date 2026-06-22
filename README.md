# BMart — Retail Management System

Built as a project after my internship at LOGOS, BMart is an Oracle APEX application for a fictional small shop that needs a system usable by both managers and cashiers. It integrates Oracle SQL, PL/SQL packages, and custom CSS.

**Environment:** Oracle APEX 20.1 + Oracle Database 11g

---

There are two roles in the system: Manager and Cashier.

The **manager** can:
- View, add, update and delete customers, products and product categories.
- View and add transactions.
- View price change history for products.
- Use the following analytical and report tools:
    - Find the customer count in a given city.
    - Find the transaction count between two dates.
    - Find the price of a product in a given date.
    - Find the total quantity of a product sold between two dates.
    - View the count of products per transaction.
    - View a dashboard playground giving access to customer, product, transaction, transaction and lines, and price change history data with charts for each and an interactive view of the data allowing different actions on them.
- Add a new cashier account.

The **cashier** can:
- View and add customers and transactions.
- View products, product categories and the price change history for the products.

---

## Pages

- [Customers](#customers)
- [Open a Transaction](#open-a-transaction)
- [All Transactions](#all-transactions)
- [All Products](#all-products)
- [Product Categories](#product-categories)
- [Price Change History](#price-change-history)
- [Reports and Analytics](#reports-and-analytics)
- [Tools](#tools)

---

## Customers

<img width="700" alt="Customers page overview" src="https://github.com/user-attachments/assets/8b63e250-9ca5-424f-900c-e76de3ffe1d1" />

Adding a customer requires: First Name, Last Name, City, Street and Phone Number. The primary key ID is assigned by a sequence.

**Business rule:** A customer's phone number must be unique — no two customers can share the same number, and updates are subject to the same constraint.

The data is displayed in an interactive grid that allows editing and deleting records. Adding through the grid was intentionally removed; it's simpler to add through a separate form with dedicated input fields.

For convenience, the customer ID column is replaced with a "View Transactions" link (search icon) that opens a modal showing all transactions for that customer, with a Products sub-view that updates as the user selects a transaction row.

<img width="500" alt="Add customer form" src="https://github.com/user-attachments/assets/bb421f09-b04d-44c4-9846-a85ab583c23d" />

<img width="700" alt="View transactions modal on customers page" src="https://github.com/user-attachments/assets/f8a588bd-9b6c-4a42-8c8c-307518961999" />

[Screencast_20260622_081203.webm](https://github.com/user-attachments/assets/1341682d-70f2-4336-a169-d9bf32233f3b)

---

## Open a Transaction

Opening a new transaction involves three steps.

[Screencast_20260622_081557.webm](https://github.com/user-attachments/assets/863029b6-c16c-457d-910b-0052cb219006)

### Step 1 — Select a Customer

<img width="700" alt="Customer selection step" src="https://github.com/user-attachments/assets/ccc073dc-55f8-4d78-9e65-0b95be7a7a15" />

The user selects a customer either from a dropdown (name + phone number) or by entering a phone number directly. The system fetches the customer on clicking Start Transaction. Optional comments can be added.

<img width="700" alt="Customer selected state" src="https://github.com/user-attachments/assets/da3f7b33-b20d-4636-8700-30cdb9a0a165" />

### Step 2 — Add Products

<img width="700" alt="Add products step" src="https://github.com/user-attachments/assets/05fc8781-5e29-4f6b-b3f5-684661513499" />

After clicking Start Transaction, a product section opens alongside the customer section. The user selects a product from a dropdown and specifies a quantity, then clicks "Add a Product" to add it to the transaction.

Notes:
- The product list is an interactive grid — the user can only delete rows. To change a quantity, the row must be deleted and re-added.
- The total line amount is computed from unit price × quantity and cannot be manually edited.

### Step 3 — Transaction Summary

<img width="700" alt="Transaction summary section" src="https://github.com/user-attachments/assets/59930659-ad52-4994-b01e-cee2759b08db" />

Once at least one product is added, a summary section appears showing the transaction date, total amount, and product count. A "Finalize Transaction" button refreshes the page to start a new transaction.

---

## All Transactions

<img width="700" alt="All transactions page" src="https://github.com/user-attachments/assets/8d2ad9fd-7834-4b18-8f0e-4aeb6cad6df7" />

Transactions cannot be modified for accounting purposes. The interactive report displays:

- **View Customer Info** — icon link opening a modal with the customer's details (name, phone, city, street)
- **Transaction Date**
- **Total Amount** — pre-computed as products were added, not calculated on the fly
- **Comments** — optional
- **View Products** — icon link opening a modal listing the products in the transaction (title, quantity, line amount)
- **Transaction ID**

The report supports filtering, sorting, column reordering, aggregation, and creating charts and pivot tables.

[Screencast_20260622_082025.webm](https://github.com/user-attachments/assets/102ab9bf-f01a-497f-8405-00ce7da2e965)

<img width="500" alt="Transaction report actions menu" src="https://github.com/user-attachments/assets/ce9286d6-e3cf-49cd-a207-f6b3797789fe" />

---

## All Products

<img width="700" alt="All products page" src="https://github.com/user-attachments/assets/a29f696f-9e09-477f-829f-8942bb88cc10" />

Managers can view, add, update and delete products. Cashiers can only view.

The interactive grid displays:
- **Product ID** — assigned by a sequence, read-only
- **Title**
- **Category** — changeable via dropdown
- **Unit Price** — $0.10–$9,999.00; changes are logged to the price history table
- **Last Updated Price Date** — auto-updated on insert/price change, read-only
- **Description** — optional
- **Unique Product Code** — must be non-empty and unique across all products

Chart and pivot actions are disabled on this grid to keep the page minimal. A search bar is available.

[Screencast_20260622_082506.webm](https://github.com/user-attachments/assets/e155122d-2073-4d76-b0da-33afd2379259)

---

## Product Categories

<img width="700" alt="Product categories page" src="https://github.com/user-attachments/assets/c452f595-2f89-4fbb-b6e2-94bb0e4cb00f" />

Managers can view, add, update and delete categories. Cashiers can only view.

The interactive grid displays:
- **View Products** — icon link (the category ID) opening a modal where the manager can add/update/remove products within that category; cashiers can only view
- **Title**
- **Description** — optional

Adding and updating is done through the grid. Deletion is handled by a separate "Delete a Category" button that opens a modal with a dropdown and a confirmation checkbox.

[Screencast_20260622_112727.webm](https://github.com/user-attachments/assets/806953b6-907f-4bd2-b77f-18c579f23de0)

<img width="700" alt="Delete category modal" src="https://github.com/user-attachments/assets/0294f70e-9486-4c31-a436-39c87ad172fa" />

**Business rules:**
- Deleting a category cascades to all products within it and their price change history.
- A category can only be deleted if none of its products appear in any transaction.

[Screencast_20260622_112905.webm](https://github.com/user-attachments/assets/9345a7c7-bdf3-4d71-9571-7eda151876fc)

---

## Price Change History

<img width="700" alt="Price change history page" src="https://github.com/user-attachments/assets/cd114706-00f2-4297-875d-b8f96ce9797f" />

Available to both roles. Displays:
- Change Date
- Product Title
- Unit Price (changed to)

The interactive report supports column toggling, row/column filters, chart creation, saved report configurations, and PDF/CSV export.

<img width="500" alt="Price change history actions menu" src="https://github.com/user-attachments/assets/3085a3bb-83a3-4847-94e0-401bc1b183f0" />

---

## Reports and Analytics

<img width="700" alt="Reports and analytics navigation" src="https://github.com/user-attachments/assets/98d50c33-8ad2-49ce-828e-196805356a26" />

### 1. Dashboard Playground

<img width="700" alt="Dashboard playground" src="https://github.com/user-attachments/assets/4eca16d1-c3f5-45ee-94e7-722e58cd086f" />

An interactive report featuring the following datasets, each with action buttons for charts, pivot tables, and filters:

**Customers**
- Chart: number of customers per city
- Click a chart item to open a modal listing customers in that city

**Products**
- Chart 1: Total Products Per Category
- Chart 2: Value of Each Category
- Click a chart item to open a modal showing products in that category (add/update/remove for managers)

**Transactions**
- Shows all transactions with full customer names
- Summary chart: lowest, highest, and average total amounts
- Click min/max to view the products in those transactions

**Transactions and Products**
- Shows all transactions with associated products: title, customer name, quantity, line amount, transaction total
- Pie charts: Customer's Total Quantity Purchased · Customer's Total Amount Spent
- Click a pie slice to view that customer's transactions and products

**Price Change History**
- Shows product title, change date, product ID, and new unit price
- "Find Price of a Product on a Date" button for historical price lookups

[Screencast_20260622_114113.webm](https://github.com/user-attachments/assets/0475b717-9586-4189-9dfe-18d78f8f742b)

### 2. Customer Count in a Given City

<img width="700" alt="Customer count by city" src="https://github.com/user-attachments/assets/bd476d18-03f6-4d80-8c9a-1c488f4b9a81" />

Select a city to view the total number of customers located there.

### 3. Transaction Count Between Two Dates

<img width="700" alt="Transaction count between dates" src="https://github.com/user-attachments/assets/a32b7b87-c252-4576-91da-6071a73c7738" />

Specify a date range to get the total number of transactions completed.

### 4. Price of a Product on a Given Date

<img width="700" alt="Price of product on given date" src="https://github.com/user-attachments/assets/f303c0b3-749c-4af2-ba57-6f2931cbfeca" />

Select a product and date to retrieve its price on that date. If no price change occurred on that exact date, the most recent prior price is returned.

### 5. Total Quantity of a Product Sold Between Two Dates

<img width="700" alt="Total quantity sold between dates" src="https://github.com/user-attachments/assets/5f46de55-f4cf-4bbb-8f64-b09e05f03ecf" />

Select a product and date range to find the total quantity sold during that period.

### 6. Count of Products Per Transaction

<img width="700" alt="Count of products per transaction page" src="https://github.com/user-attachments/assets/8547547a-c360-499f-8575-7172e6cfc3f5" />

**Interactive Report:** transactions with product count per transaction, a View Products icon link, and a View Customer Info icon link.

**Pie Charts:** Customer's Total Quantity Purchased · Customer's Total Amount Spent

[Screencast_20260622_114556.webm](https://github.com/user-attachments/assets/f77d32af-f14e-4109-9391-b5af53a840f2)

---

## Tools

### Import from Excel

<img width="700" alt="Import from Excel page" src="https://github.com/user-attachments/assets/88bfea0f-430c-49d9-9f4e-88de27cefc20" />

Allows managers to import product data from an Excel file with three columns: product code, product title, unit price. The system processes each row and logs errors without stopping the import.

**Logged errors:**
- Product title is empty
- Product code is empty
- Unit price is empty or negative
- Product code already exists in the products table

### Add a New Cashier

<img width="700" alt="Add new cashier form" src="https://github.com/user-attachments/assets/4fa06a17-6567-4edf-8238-426f0c01228a" />

Allows managers to create new cashier accounts by specifying a username and password.

---

## Repository Contents

| File/Folder | Description |
|------|-------------|
| `sequences` | DDL for all `bmart_` sequences |
| `tables` | DDL for all `bmart_` tables |
| `DATA_ENTRY.sql` | `data_entry` package spec (DML procedures) |
| `DATA_ENTRY.plb` | `data_entry` package body |
| `SHOP_FUNCTIONS.sql` | `shop_functions` package spec |
| `SHOP_FUNCTIONS.plb` | `shop_functions` package body |
| `BMART_AUTH_USER.sql` | `bmart_auth_user` function that is used by APEX to create accounts in custom authentication |

---

## Stack

- Oracle APEX 20.1
- Oracle Database 11g (SQL + PL/SQL)
- CSS (Theme Roller + custom application-level styles)
- JavaScript (minor integrations)
