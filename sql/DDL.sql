-- User Table

Create Table User(
	uid int primary key auto increment,
	name varchar(20),
	id int,
	pw varchar(100),
	email varchar(100),
	fid int,
	FOREIGN KEY (fid) REFERENCES family(fid)
);


-- Post Table
제목 / 사진 1개 / 날짜 / 설명 / 위치  

Create Table Post(
		pid int primary key auto increment, --id 값
		title varchar(30), --제목
		description TEXT, -- 설명
		start_date Date, -- 시작 날짜
		end_date Date, -- 끝 날짜
		location varchar(100), --위치 정보
		imgsrc varchar(150), -- 이미지 url
		fid int, --가족 그룹 정보
		FOREIGN KEY (fid) REFERENCES family(fid)
);

-- Scheduler Table


Create Table Scheduler(
		sid int primary key auto increment,
    title VARCHAR(30),
    start_date DATE,
    end_date DATE,
    location VARCHAR(100),
    fid int,
    uid INT,
    FOREIGN KEY (uid) REFERENCES user(uid),
    FOREIGN KEY (fid) REFERENCES family(fid)    
);


-- Recommend Table


Create Table Recommend(
		rid int primary key auto increment,
		title varchar(30),
		description TEXT,
		priority int
);


-- Family Table


Create Table Family(
		fid int primary key auto increment,
		fname varchar(30), --?
		fdescription varchar(100),
		
);