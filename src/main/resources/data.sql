DROP DATABASE IF EXISTS db_semiProject;
CREATE DATABASE IF NOT EXISTS db_semiProject;

USE db_semiProject;

DROP TABLE IF EXISTS tbl_comment;
DROP TABLE IF EXISTS tbl_blog;
DROP TABLE IF EXISTS tbl_attach;
DROP TABLE IF EXISTS tbl_notice;
DROP TABLE IF EXISTS tbl_user;

CREATE TABLE IF NOT EXISTS tbl_user
(
 user_id INT AUTO_INCREMENT NOT NULL,
 user_pw VARCHAR(10),
 user_email VARCHAR(100) NOT NULL UNIQUE,
 user_name   VARCHAR(100),
 profile_img VARCHAR(1000),
 CONSTRAINT pk_user PRIMARY KEY(user_id)
)ENGINE=InnoDB COMMENT '유저';

CREATE TABLE IF NOT EXISTS tbl_blog
(
blog_id INT AUTO_INCREMENT NOT NULL COMMENT '블로그아이디',
user_id INT NOT NULL COMMENT '유저아이디',
title VARCHAR(100) COMMENT '제목',
hit INT COMMENT '조회수',
contents TEXT COMMENT '내용',
create_dt DATETIME COMMENT '작성일자',
modify_dt DATETIME COMMENT '수정일자',
CONSTRAINT pk_blog PRIMARY KEY (blog_id),
CONSTRAINT fk_user_blog FOREIGN KEY (user_id)
REFERENCES tbl_user (user_id) ON DELETE CASCADE
)ENGINE=InnoDB COMMENT '블로그';


CREATE TABLE IF NOT EXISTS tbl_comment
(
comment_id INT AUTO_INCREMENT NOT NULL COMMENT '댓글아이디',
user_id INT NOT NULL COMMENT '유저아이디',
blog_id INT NOT NULL COMMENT '블로그아이디',
contents VARCHAR(1000) COMMENT '내용',
CONSTRAINT pk_comment PRIMARY KEY (comment_id),
CONSTRAINT fk_user_comment FOREIGN KEY (user_id)
REFERENCES tbl_user (user_id) ON DELETE CASCADE,
CONSTRAINT fk_blog_comment FOREIGN KEY (blog_id)
REFERENCES tbl_blog (blog_id) ON DELETE CASCADE
)ENGINE=InnoDB COMMENT '댓글';

CREATE TABLE IF NOT EXISTS tbl_notice
(
    notice_id INT NOT NULL AUTO_INCREMENT COMMENT '공지사항아이디',
    user_id INT,
    notice_title VARCHAR(100) NOT NULL,
    notice_contents VARCHAR(1000) NULL,
    created_at DATETIME NULL,
    CONSTRAINT pk_notice PRIMARY KEY (notice_id),
    CONSTRAINT fk_user_notice FOREIGN KEY (user_id)
        REFERENCES tbl_user (user_id) ON DELETE SET NULL -- 공지사항 작성자가 없어지면 해당 작성자 정보를 NULL 처리한다.
)ENGINE=INNODB COMMENT='공지사항';

CREATE TABLE IF NOT EXISTS tbl_attach
(
    attach_id INT NOT NULL AUTO_INCREMENT,
    notice_id INT,
    file_path VARCHAR(100),
    original_filename VARCHAR(100),
    filesystem_name VARCHAR(100),
    download_count INT,
    CONSTRAINT pk_attcah PRIMARY KEY (attach_id),
    CONSTRAINT fk_notice_attach FOREIGN KEY (notice_id)
        REFERENCES tbl_notice (notice_id) ON DELETE CASCADE
)ENGINE=INNODB COMMENT='첨부파일';

INSERT INTO tbl_user VALUES (NULL, 'admin@naver.com', SHA2('1234', 256), '관리자', null);
INSERT INTO tbl_user VALUES (NULL, 'chan@naver.com', SHA2('chan', 256), '관리자', NULL);
COMMIT;