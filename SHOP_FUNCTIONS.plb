create or replace PACKAGE BODY shop_functions AS
    -- Public functions
    FUNCTION get_prod_count_per_tx
        RETURN SYS_REFCURSOR
    IS
        v_cursor_data SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor_data FOR
            SELECT bl.transaction_id, b.customer_id, b.total_amount,
                   COUNT(*) AS product_counts
            FROM bmart_transaction_lines bl
            JOIN bmart_transactions b
            ON bl.transaction_id = b.transaction_id
            GROUP BY bl.transaction_id, b.customer_id, b.total_amount;

        RETURN v_cursor_data;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20999, 'An error occurred: ' || SQLERRM);
    END get_prod_count_per_tx;

    FUNCTION get_cust_count_in_given_city
        (p_city bmart_customers.city%TYPE)
        RETURN NUMBER
    IS
        v_count NUMBER;
        v_city_formatted bmart_customers.city%TYPE := INITCAP(TRIM(p_city));
    BEGIN
        IF (v_city_formatted IS NULL OR v_city_formatted = '') THEN
            RAISE_APPLICATION_ERROR(-20999, 'You have to pass the name of a city to search.');
        END IF;

        SELECT COUNT(*) INTO v_count
        FROM bmart_customers
        WHERE city = v_city_formatted;

        RETURN v_count;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, 'An error occurred: ' || SQLERRM);
    END get_cust_count_in_given_city;

    FUNCTION get_trans_count_bet_two_dates
        (p_start_date VARCHAR2,
         p_end_date VARCHAR2)
         RETURN NUMBER
    IS
        v_count NUMBER;
        v_start_date DATE;
        v_end_date DATE;
    BEGIN
        v_start_date := TO_DATE(p_start_date, 'dd-mm-yyyy');
        v_end_date := TO_DATE(p_end_date, 'dd-mm-yyyy');

        IF v_start_date > v_end_date THEN
            RAISE_APPLICATION_ERROR(-20999, 'The start date must be before the end date.');
        END IF;

        SELECT COUNT(*) INTO v_count
        FROM bmart_transactions
        WHERE TRUNC(trans_date) BETWEEN v_start_date AND v_end_date;

        RETURN v_count;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, 'Ensure that the start and end dates are in this format: DD-MM-YYYY.' || CHR(10) || 'This error occurred: ' || SQLERRM);
    END get_trans_count_bet_two_dates;

    FUNCTION get_prod_price_by_date
        (p_product_id bmart_products.product_id%TYPE,
         p_given_date VARCHAR2)
         RETURN NUMBER
    IS
        v_given_date_formatted DATE := TO_DATE(p_given_date, 'dd-mm-yyyy');
        v_price bmart_price_change_history.unit_price%TYPE;
    BEGIN
		SELECT unit_price INTO v_price
		FROM (
			SELECT unit_price
			FROM bmart_price_change_history
			WHERE product_id = p_product_id
			  AND TRUNC(change_date) <= v_given_date_formatted
			ORDER BY change_date DESC
		)
		WHERE ROWNUM = 1; --only the recent one, if a price change wasn't done specifically on the given date.'
		
        RETURN v_price;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'No price found for product #' || p_product_id || ' on that date.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'Ensure that the given date is in this format: DD-MM-YYYY.'|| CHR(10) || 'This error occurred: ' || SQLERRM);
    END get_prod_price_by_date;

    FUNCTION get_prod_qty_between_dates
        (p_product_id bmart_products.product_id%TYPE,
         p_start_date VARCHAR2,
         p_end_date VARCHAR2)
         RETURN NUMBER
    IS
        v_total_qt bmart_transaction_lines.quantity%TYPE;
        v_start_date DATE := TO_DATE(p_start_date, 'dd-mm-yyyy');
        v_end_date DATE := TO_DATE(p_end_date, 'dd-mm-yyyy');
    BEGIN
        IF v_start_date > v_end_date THEN
            RAISE_APPLICATION_ERROR(-20999, 'The start date must be before the end date.');
        END IF;

        SELECT SUM(quantity) INTO v_total_qt
        FROM bmart_transaction_lines tl
        JOIN bmart_transactions t ON t.transaction_id = tl.transaction_id
        WHERE TRUNC(t.trans_date) BETWEEN v_start_date AND v_end_date
          AND tl.product_id = p_product_id;

        IF v_total_qt IS NULL OR v_total_qt = 0 THEN
            RAISE_APPLICATION_ERROR(-20999, 'No transaction found for product ID #' || p_product_id || ' between the given dates.');
        END IF;

        RETURN v_total_qt;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, 'Ensure that the start and end dates are in this format: DD-MM-YYYY.' || CHR(10) || 'This error occurred: ' || SQLERRM);
    END get_prod_qty_between_dates;
END shop_functions;
