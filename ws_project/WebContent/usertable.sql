create database jyp;

USE jyp;

CREATE TABLE IF NOT EXISTS jypuser(
	name VARCHAR(10),
	id VARCHAR(12),
	pw VARCHAR(20)
	);
	
INSERT INTO jypuser (name, id, pw) VALUES ('Admin', 'admin', '123456');

CREATE TABLE guestbook (
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


