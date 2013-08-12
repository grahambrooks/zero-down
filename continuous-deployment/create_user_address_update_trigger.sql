DELIMITER //
DROP TRIGGER iF EXISTS update_user_address //

CREATE TRIGGER update_user_address AFTER UPDATE ON user FOR EACH ROW
BEGIN
       UPDATE user_address SET address_line_1 = NEW.address_line_1, address_line_2 = NEW.address_line_2 WHERE user_id = NEW.id;

       INSERT INTO user_address (user_id, address_line_1, address_line_2)
       SELECT u.id, u.address_line_1, u.address_line_2
       FROM user u
       LEFT JOIN user_address ua ON ua.user_id = u.id
       WHERE ua.user_id IS NULL;
END
//
