create or replace PROCEDURE bmart_add_cashier (
    p_username IN VARCHAR2,
    p_password IN VARCHAR2
) IS
    v_count NUMBER;
    v_hash  VARCHAR2(255);
BEGIN
    SELECT COUNT(*) INTO v_count 
    FROM bmart_users 
    WHERE UPPER(username) = UPPER(p_username);
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Username "' || p_username || '" is already taken.');
    END IF;

    v_hash := LOWER(DBMS_CRYPTO.HASH(UTL_I18N.STRING_TO_RAW(p_password || 'BMART_SALT', 'AL32UTF8'), 2));

    INSERT INTO bmart_users (username, password_hash, is_manager, is_active)
    VALUES (p_username, v_hash, 'N', 'Y');
END bmart_add_cashier;
