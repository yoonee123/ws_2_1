USE odbo;

CREATE TABLE IF NOT EXISTS heightData(
    name VARCHAR(20) PRIMARY KEY,
    height int,
    signuptime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

SHOW tables;

DESC heightData;