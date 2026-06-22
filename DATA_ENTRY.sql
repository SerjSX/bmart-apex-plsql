create or replace PACKAGE data_entry AS
    PROCEDURE add_customer(
        p_f_name bmart_customers.first_name%TYPE,
        p_l_name bmart_customers.last_name%TYPE,
        p_phone_number bmart_customers.phone_number%TYPE,
        p_city bmart_customers.city%TYPE,
        p_street bmart_customers.street%TYPE
    );
    PROCEDURE add_product_category(
        p_title bmart_product_categories.title%TYPE,
        p_description bmart_product_categories.description%TYPE
    );
    PROCEDURE add_product(
        p_title bmart_products.title%TYPE,
        p_category_id bmart_products.category_id%TYPE,
        p_unit_price bmart_products.unit_price%TYPE,
        p_description bmart_products.description%TYPE,
        p_product_code_uk bmart_products.product_code_uk%TYPE,
        p_out_prod_id OUT bmart_products.product_id%TYPE
    );
    PROCEDURE update_product_price(
        p_product_id bmart_price_change_history.product_id%TYPE,
        p_new_price bmart_price_change_history.unit_price%TYPE
    );
    PROCEDURE add_transaction(
        p_customer_id bmart_transactions.customer_id%TYPE,
        p_comments bmart_transactions.comments%TYPE,
        p_out_trans_id OUT bmart_transactions.transaction_id%TYPE
    );
    PROCEDURE add_transaction_line(
        p_transaction_id bmart_transaction_lines.transaction_id%TYPE,
        p_product_id bmart_transaction_lines.product_id%TYPE,
        p_quantity bmart_transaction_lines.quantity%TYPE
    );
    PROCEDURE bmart_add_cashier (
        p_username IN VARCHAR2,
        p_password IN VARCHAR2
    );
END data_entry;
