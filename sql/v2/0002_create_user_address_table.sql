DROP TABLE IF EXISTS addresses;
//
CREATE TABLE addresses (
        id int(11) NOT NULL AUTO_INCREMENT,
	user_id INT NOT NULL,
	address_line_1 VARCHAR(100),
      	address_line_2 VARCHAR(100),
	PRIMARY KEY (id),

	FOREIGN KEY (user_id) REFERENCES users(id)
);
//
DROP TRIGGER IF EXISTS create_addresses_trigger;
//
CREATE TRIGGER create_addresses_trigger AFTER INSERT ON users FOR EACH ROW
       INSERT INTO addresses (user_id, address_line_1, address_line_2) VALUES(NEW.id, NEW.address_line_1, NEW.address_line_2);
//
DROP TRIGGER iF EXISTS update_addresses_trigger;
//
CREATE TRIGGER update_addresses_trigger AFTER UPDATE ON users FOR EACH ROW
BEGIN
       UPDATE addresses SET address_line_1 = NEW.address_line_1, address_line_2 = NEW.address_line_2 WHERE user_id = NEW.id;

       INSERT INTO addresses (user_id, address_line_1, address_line_2)
       SELECT u.id, u.address_line_1, u.address_line_2
       FROM user u
       LEFT JOIN addresses ua ON ua.user_id = u.id
       WHERE ua.user_id IS NULL;
END
//

CREATE TRIGGER user_delete_addresses_trigger BEFORE DELETE ON users FOR EACH ROW
       DELETE FROM addresses WHERE user_id = OLD.id;
//
INSERT INTO addresses (user_id, address_line_1, address_line_2)
       SELECT u.id, u.address_line_1, u.address_line_2
       FROM users u
       LEFT JOIN addresses ua ON ua.user_id = u.id
       WHERE ua.user_id IS NULL
;
