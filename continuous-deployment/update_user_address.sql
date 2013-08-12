INSERT INTO user_address (user_id, address_line_1, address_line_2)
       SELECT u.id, u.address_line_1, u.address_line_2
       FROM user u
       LEFT JOIN user_address ua ON ua.user_id = u.id
       WHERE ua.user_id IS NULL
;
