create or replace PACKAGE BODY data_entry AS
    -- Private procedures
    PROCEDURE log_price_change(
        p_product_id bmart_price_change_history.product_id%TYPE,
        p_new_price bmart_price_change_history.unit_price%TYPE,
        p_date DATE
    )
    IS
    BEGIN
        INSERT INTO bmart_price_change_history (product_id, change_date, unit_price)
            VALUES (p_product_id, p_date, p_new_price);

        DBMS_OUTPUT.PUT_LINE('Successfully logged the price change for product #' || p_product_id);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20999, 'Failled to log the price change. An error occurred: ' || SQLERRM);
    END log_price_change;

    PROCEDURE update_transaction_amount(
        p_transaction_id bmart_transactions.transaction_id%TYPE,
        p_cost bmart_transactions.total_amount%TYPE
    )
    IS
    BEGIN
        UPDATE bmart_transactions
        SET total_amount = total_amount + p_cost
        WHERE transaction_id = p_transaction_id;

        DBMS_OUTPUT.PUT_LINE('Successfully updated the primary transaction''s total amount.');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20999, 'Failed to update the primary transaction''s total amount, an error occurred: ' || SQLERRM);
    END update_transaction_amount;

    -- Public procedures
    PROCEDURE add_customer(
        p_f_name bmart_customers.first_name%TYPE,
        p_l_name bmart_customers.last_name%TYPE,
        p_phone_number bmart_customers.phone_number%TYPE,
        p_city bmart_customers.city%TYPE,
        p_street bmart_customers.street%TYPE
    )
    IS
    BEGIN
        INSERT INTO bmart_customers (customer_id, first_name, last_name, phone_number, city, street)
        VALUES (bmart_cust_id_seq.NEXTVAL,
               INITCAP(p_f_name), INITCAP(p_l_name), p_phone_number,
               INITCAP(p_city), INITCAP(p_street));

        DBMS_OUTPUT.PUT_LINE('Successfully added the new customer with ID #' || bmart_cust_id_seq.CURRVAL);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20999, 'Failed to add the new customer due to the following error: ' || SQLERRM);
    END add_customer;

    PROCEDURE add_product_category(
        p_title bmart_product_categories.title%TYPE,
        p_description bmart_product_categories.description%TYPE
    )
    IS
        v_title_cleaned bmart_product_categories.title%TYPE := INITCAP(TRIM(p_title));
    BEGIN
        IF (v_title_cleaned IS NULL OR v_title_cleaned = '') THEN
            RAISE_APPLICATION_ERROR(-20999, 'Title cannot be empty!');
        END IF;

        INSERT INTO bmart_product_categories (category_id, title, description)
            VALUES (bmart_prod_cat_id_seq.NEXTVAL, v_title_cleaned, p_description);

        DBMS_OUTPUT.PUT_LINE('Successfully added the new product category with ID #' || bmart_prod_cat_id_seq.CURRVAL);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20999, 'An error occurred: ' || SQLERRM);
    END add_product_category;

    PROCEDURE add_product(
        p_title bmart_products.title%TYPE,
        p_category_id bmart_products.category_id%TYPE,
        p_unit_price bmart_products.unit_price%TYPE,
        p_description bmart_products.description%TYPE,
        p_product_code_uk bmart_products.product_code_uk%TYPE,
        p_out_prod_id OUT bmart_products.product_id%TYPE
    )
    IS
        v_title_cleaned bmart_products.title%TYPE := INITCAP(TRIM(p_title));
        v_date DATE := SYSDATE;
        v_product_code_uk_count NUMBER;
    BEGIN
        IF (p_product_code_uk IS NULL OR TRIM(p_product_code_uk) = '') THEN
            RAISE_APPLICATION_ERROR(-20999, 'Product code cannot be empty!');
        ELSIF (p_title IS NULL OR TRIM(p_title) = '') THEN
            RAISE_APPLICATION_ERROR(-20999, 'Product''s title cannot be empty.');
        ELSIF (v_title_cleaned IS NULL OR v_title_cleaned = '') THEN
            RAISE_APPLICATION_ERROR(-20999, 'Title cannot be empty!');
        ELSIF (p_unit_price < 0) THEN
            RAISE_APPLICATION_ERROR(-20999, 'The unit price must be greater than 0.');
        END IF;
        
        SELECT COUNT(*) INTO v_product_code_uk_count
        FROM bmart_products
        WHERE product_code_uk = p_product_code_uk;
        
        IF v_product_code_uk_count > 0 THEN
            RAISE_APPLICATION_ERROR(-20999, 'There is another product with the exact same product code!');
        END IF;
        
        p_out_prod_id := bmart_prod_id_seq.NEXTVAL;

        INSERT INTO bmart_products (product_id, product_code_uk, title, description, category_id, unit_price, last_updated_price_date)
            VALUES (p_out_prod_id, p_product_code_uk, v_title_cleaned, p_description,
                    p_category_id, p_unit_price, v_date);

        log_price_change(p_out_prod_id, p_unit_price, v_date);

        DBMS_OUTPUT.PUT_LINE('Successfully added the new product and logged its initial price.');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error occurred: ' || SQLERRM);
    END add_product;

    PROCEDURE update_product_price(
        p_product_id bmart_price_change_history.product_id%TYPE,
        p_new_price bmart_price_change_history.unit_price%TYPE
    )
    IS
        v_date DATE := SYSDATE;
    BEGIN
        IF (p_new_price <= 0) THEN
            RAISE_APPLICATION_ERROR(-20999, 'The new price must be greater than 0.');
        END IF;

        UPDATE bmart_products
        SET unit_price = p_new_price,
            last_updated_price_date = v_date
        WHERE product_id = p_product_id;

        log_price_change(p_product_id, p_new_price, v_date);

        DBMS_OUTPUT.PUT_LINE('Successfully updated the price of product ID #' || p_product_id || ' and logged it.');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error occurred: ' || SQLERRM);
    END update_product_price;

    PROCEDURE add_transaction(
        p_customer_id bmart_transactions.customer_id%TYPE,
        p_comments bmart_transactions.comments%TYPE,
        p_out_trans_id OUT bmart_transactions.transaction_id%TYPE
    )
    IS
        v_transaction_id bmart_transactions.transaction_id%TYPE;
    BEGIN
        v_transaction_id := bmart_trans_id_seq.NEXTVAL;
    
        INSERT INTO bmart_transactions (transaction_id, trans_date, total_amount, comments, customer_id)
            VALUES (v_transaction_id,
                    SYSDATE,
                    0,
                    p_comments,
                    p_customer_id);
        DBMS_OUTPUT.PUT_LINE('Successfully opened a new transaction for customer ID #' || p_customer_id);
        
        p_out_trans_id := v_transaction_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20999, 'An error occurred: ' || SQLERRM);
    END add_transaction;

    PROCEDURE add_transaction_line(
        p_transaction_id bmart_transaction_lines.transaction_id%TYPE,
        p_product_id bmart_transaction_lines.product_id%TYPE,
        p_quantity bmart_transaction_lines.quantity%TYPE
    )
    IS
        v_unit_price bmart_products.unit_price%TYPE;
    BEGIN
        IF (p_quantity <= 0) THEN
            RAISE_APPLICATION_ERROR(-20999, 'The quantity must be greater than 0 to add as a transaction line.');
        END IF;

        SELECT unit_price INTO v_unit_price FROM bmart_products WHERE product_id = p_product_id;

        INSERT INTO bmart_transaction_lines (transaction_id, product_id, quantity, total_line_amount)
            VALUES (p_transaction_id, p_product_id, p_quantity,
                    p_quantity * v_unit_price);
                    
        update_transaction_amount(p_transaction_id, p_quantity * v_unit_price);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'Product not found.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error occurred: ' || SQLERRM);
    END add_transaction_line;
    
    PROCEDURE bmart_add_cashier (
        p_username IN VARCHAR2,
        p_password IN VARCHAR2
    ) IS
        v_count NUMBER;
        v_hash  VARCHAR2(255);
    BEGIN
        -- 1. Check if username already exists to prevent raw constraint crashes
        SELECT COUNT(*) INTO v_count 
        FROM bmart_users 
        WHERE UPPER(username) = UPPER(p_username);

        IF v_count > 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Username "' || p_username || '" is already taken.');
        END IF;

        -- 2. Hash the password using the native 11g SHA-1 method matching your login
        v_hash := LOWER(DBMS_CRYPTO.HASH(UTL_I18N.STRING_TO_RAW(p_password || 'BMART_SALT', 'AL32UTF8'), 2));

        -- 3. Insert the new cashier (is_manager defaults to 'N')
        INSERT INTO bmart_users (username, password_hash, is_manager, is_active)
        VALUES (p_username, v_hash, 'N', 'Y');
    END bmart_add_cashier;

END data_entry;
