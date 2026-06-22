create or replace FUNCTION bmart_auth_user (
    p_username IN VARCHAR2,
    p_password IN VARCHAR2
) RETURN BOOLEAN 
IS
    v_stored_hash VARCHAR2(255);
    v_input_hash  VARCHAR2(255);
    v_active      VARCHAR2(1);
BEGIN
    -- 1. Fetch user parameters
    SELECT password_hash, is_active
    INTO v_stored_hash, v_active
    FROM bmart_users
    WHERE UPPER(username) = UPPER(p_username);

    -- 2. Disallow deactivated staff members
    IF v_active = 'N' THEN
        RETURN FALSE;
    END IF;

    -- 3. Re-hash the submitted text input using native database rules
    v_input_hash := LOWER(DBMS_CRYPTO.HASH(UTL_I18N.STRING_TO_RAW(p_password || 'BMART_SALT', 'AL32UTF8'), 2));

    -- 4. Evaluate match condition
    IF v_stored_hash = v_input_hash THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE; -- Account username does not exist
    WHEN OTHERS THEN
        RETURN FALSE;
END bmart_auth_user;
