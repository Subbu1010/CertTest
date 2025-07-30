-- Create tbl_users table
CREATE TABLE IF NOT EXISTS tbl_users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
); 