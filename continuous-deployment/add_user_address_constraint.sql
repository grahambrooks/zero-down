ALTER TABLE user_address
      ADD FOREIGN KEY (user_id) REFERENCES user(id)
;
