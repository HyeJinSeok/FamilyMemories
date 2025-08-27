-- Family Table
CREATE TABLE Family (
    fid          INT PRIMARY KEY AUTO_INCREMENT,
    fname        VARCHAR(30),
    fdescription VARCHAR(100)
);

-- Users Table
CREATE TABLE Users (
    uid   INT PRIMARY KEY AUTO_INCREMENT,
    name  VARCHAR(20),
    id    INT,
    pw    VARCHAR(100),
    email VARCHAR(100),
    fid   INT,
    FOREIGN KEY (fid) REFERENCES Family(fid)
);

-- Post Table
CREATE TABLE Post (
    pid         INT PRIMARY KEY AUTO_INCREMENT,
    title       VARCHAR(30),
    description TEXT,
    start_date  DATE,
    end_date    DATE,
    location    VARCHAR(100),
    imgsrc      VARCHAR(150),
    fid         INT,
    uid         INT,
    FOREIGN KEY (fid) REFERENCES Family(fid),
    FOREIGN KEY (uid) REFERENCES Users(uid)
);

-- Scheduler Table
CREATE TABLE Scheduler (
    sid        INT PRIMARY KEY AUTO_INCREMENT,
    title      VARCHAR(30),
    start_date DATE,
    end_date   DATE,
    location   VARCHAR(100),
    fid        INT,
    uid        INT,
    FOREIGN KEY (uid) REFERENCES Users(uid),
    FOREIGN KEY (fid) REFERENCES Family(fid)
);

-- Recommend Table
CREATE TABLE Recommend (
    rid         INT PRIMARY KEY AUTO_INCREMENT,
    title       VARCHAR(30),
    description TEXT,
    priority    INT
);