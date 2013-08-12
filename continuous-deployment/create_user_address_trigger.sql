CREATE TRIGGER create_user_address AFTER INSERT ON user FOR EACH ROW
       INSERT INTO user_address (user_id, address_line_1, address_line_2) VALUES(NEW.id, NEW.address_line_1, NEW.address_line_2);
