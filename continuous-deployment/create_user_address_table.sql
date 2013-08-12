CREATE TABLE user_address (
        id int(11) NOT NULL AUTO_INCREMENT,
	user_id INT NOT NULL,
	address_line_1 VARCHAR(100),
      	address_line_2 VARCHAR(100),
	PRIMARY KEY (id),

	FOREIGN KEY (user_id) REFERENCES user(id)
);

