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

CREATE TABLE photos (
    id INT AUTO_INCREMENT PRIMARY KEY,  
    path VARCHAR(255) NOT NULL          
);

CREATE TABLE album_comments (
    id INT AUTO_INCREMENT PRIMARY KEY,  
    photo_id INT NOT NULL,              
    content TEXT NOT NULL,             
    FOREIGN KEY (photo_id) REFERENCES photos(id)  
);


