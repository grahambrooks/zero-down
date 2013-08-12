CREATE TRIGGER user_delete_user_address BEFORE DELETE ON user FOR EACH ROW
       DELETE FROM user_address WHERE user_id = OLD.id;
