

CREATE TABLE MENOON.USER
	(
		ID INT NOT NULL AUTO_INCREMENT,
		FULLNAME VARCHAR(60),
		HOMEADDRESS VARCHAR(50),
		USERNAME VARCHAR(20) UNIQUE,
		PASSWORD VARCHAR(50),
		MEMBERSHIPTYPE VARCHAR(50),
		PROFILEPHOTO BLOB,

		PRIMARY KEY(ID)


		);
	ALTER TABLE USER AUTO_INCREMENT=1;


CREATE TABLE MENOON.USER_PASSPORT_INFO
(
	USER_ID INT NOT NULL,
	PASSPORT_NO INT UNIQUE,
	PASSPORT_PHOTOCOPY BLOB,
	APPROVED BIT DEFAULT 0,

	PRIMARY KEY(PASSPORT_NO),

	FOREIGN KEY(USER_ID) REFERENCES USER(ID)
	ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE MENOON.USER_NATIONAL_ID
(
	USER_ID INT NOT NULL,
	NATIONAL_ID_NO INT UNIQUE,
	NATIONAL_ID_PHOTOCOPY BLOB,
	APPROVED BIT DEFAULT 0,

	PRIMARY KEY(NATIONAL_ID_NO),

	FOREIGN KEY(USER_ID) REFERENCES USER(ID)
	ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE MENOON.USER_BIRTH_CERTIFICATE
(
	USER_ID INT NOT NULL,
	BIRTH_CERTIFICATE_NO INT UNIQUE,
	BIRTH_CERTIFICATE_PHOTOCOPY BLOB,
	APPROVED BIT DEFAULT 0,

	PRIMARY KEY(BIRTH_CERTIFICATE_NO),

	FOREIGN KEY(USER_ID) REFERENCES USER(ID)
	ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE MENOON.USER_FINGER_PRINT
(
USER_ID INT NOT NULL,
FINGERPRINT BLOB,

PRIMARY KEY(USER_ID),

FOREIGN KEY(USER_ID) REFERENCES USER(ID)
ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE MENOON.USER_EMAILS
(
 USER_ID INT NOT NULL,
 EMAIL VARCHAR(320),
  PRIMARY1 BIT DEFAULT 0,

 PRIMARY KEY(USER_ID,EMAIL),

FOREIGN KEY(USER_ID) REFERENCES USER(ID)
ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE MENOON.USER_PHONENUMBERS
(
 USER_ID INT NOT NULL,
COUNTRY_CODE VARCHAR(5),
PHONENUMBER VARCHAR(15),
 PRIMARY1 BIT DEFAULT 0,

 PRIMARY KEY(USER_ID,COUNTRY_CODE,PHONENUMBER),

FOREIGN KEY(USER_ID) REFERENCES USER(ID)
ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE MENOON.MEMBER
(
USER_ID INT NOT NULL,
MEMBERSHIP_ID INT NOT NULL AUTO_INCREMENT,
MEMBERSHIP_CARD_STATUS VARCHAR(10),
EXPIRATION_DATE DATE,

PRIMARY KEY(MEMBERSHIP_ID),

FOREIGN KEY(USER_ID) REFERENCES USER(ID)
ON UPDATE CASCADE ON DELETE CASCADE

);
ALTER TABLE MEMBER AUTO_INCREMENT=1;

CREATE TABLE MENOON.MEMBERSHIP_PHOTOCOPIES
(
  MEMBERSHIP_ID INT NOT NULL,
  PHOTOCOPYNUMBER INT NOT NULL,
  CARD_PHOTOCOPY BLOB,

  PRIMARY KEY(PHOTOCOPYNUMBER),

  FOREIGN KEY(MEMBERSHIP_ID) REFERENCES MEMBER(MEMBERSHIP_ID)
  ON UPDATE CASCADE ON DELETE CASCADE


);

CREATE TABLE MENOON.EVENTS
(

ID INT NOT NULL AUTO_INCREMENT,
NAME VARCHAR(30) NOT NULL,
START_DATE DATE,
COUNTRY VARCHAR(50),
DESCRIPTION VARCHAR(200),

PRIMARY KEY(ID)



);

ALTER TABLE EVENTS AUTO_INCREMENT=1;
CREATE TABLE MENOON.EVENT_RULES
(
EVENT_ID INT,
RULE VARCHAR(100),

PRIMARY KEY(EVENT_ID,RULE),

FOREIGN KEY(EVENT_ID)REFERENCES EVENTS(ID)
 ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE MENOON.EVENT_TOPICS
(
EVENT_ID INT,
TOPIC VARCHAR(100),

PRIMARY KEY(EVENT_ID,TOPIC),

FOREIGN KEY(EVENT_ID)REFERENCES EVENTS(ID)
 ON UPDATE CASCADE ON DELETE CASCADE

);


CREATE TABLE MENOON.MEDIA
(
ID INT NOT NULL AUTO_INCREMENT,
EVENT_ID INT NOT NULL,
URL VARCHAR(1000),
TYPE VARCHAR(10),

PRIMARY KEY(ID),

FOREIGN KEY(EVENT_ID)REFERENCES EVENTS(ID)
 ON UPDATE CASCADE ON DELETE CASCADE


);

ALTER TABLE MEDIA AUTO_INCREMENT=1;

CREATE TABLE MENOON.USER_EVENT_NOTALLOWED
(
USER_ID INT NOT NULL,
EVENT_ID INT NOT NULL,
REASON VARCHAR(1000),

PRIMARY KEY(USER_ID,EVENT_ID),

FOREIGN KEY(EVENT_ID)REFERENCES EVENTS(ID)
 ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY(USER_ID) REFERENCES USER(ID)
ON UPDATE CASCADE ON DELETE CASCADE

);

CREATE TABLE MENOON.USER_EVENT_APPLICATIONS
(
APPLICATION_NUMBER INT NOT NULL,
USER_ID INT NOT NULL,
EVENT_ID INT NOT NULL,
APPLICATION_DATE DATE,
IQ_TEST_SCORE INT,
MONEYPAID REAL,
REFUND REAL DEFAULT 0,

PRIMARY KEY(APPLICATION_NUMBER),

FOREIGN KEY(EVENT_ID)REFERENCES EVENTS(ID)
 ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY(USER_ID) REFERENCES USER(ID)
ON UPDATE CASCADE ON DELETE CASCADE

);

CREATE TABLE MENOON.CERTIFICATES
(
USER_ID INT NOT NULL,
EVENT_ID INT NOT NULL,
PHOTOCOPY BLOB,

PRIMARY KEY(USER_ID,EVENT_ID),

FOREIGN KEY(EVENT_ID)REFERENCES EVENTS(ID)
 ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY(USER_ID) REFERENCES USER(ID)
ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE MENOON.INTERVIEW_APPLICATIONS
(
USER_ID INT NOT NULL,
EVENT_ID INT NOT NULL,
INTERVIEW_DATE_TIME TIMESTAMP,

PRIMARY KEY(USER_ID,EVENT_ID,INTERVIEW_DATE_TIME),

FOREIGN KEY(EVENT_ID)REFERENCES EVENTS(ID)
 ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY(USER_ID) REFERENCES USER(ID)
ON UPDATE CASCADE ON DELETE CASCADE



);

CREATE TABLE MENOON.TAGTABLE
(
MEDIA_ID INT NOT NULL,
USER_ID INT NOT NULL,
APPROVED BIT DEFAULT 0,

PRIMARY KEY(MEDIA_ID,USER_ID),

FOREIGN KEY(MEDIA_ID)REFERENCES MEDIA(ID)
 ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY(USER_ID) REFERENCES USER(ID)
ON UPDATE CASCADE ON DELETE CASCADE

);

CREATE TABLE MENOON.IQ_QUESTIONS
(
ID INT NOT NULL AUTO_INCREMENT,
STATEMENT VARCHAR(100),
IMAGE BLOB,
POINTS INT NOT NULL,
ANSWER CHAR(1),

PRIMARY KEY(ID)
);

ALTER TABLE IQ_QUESTIONS AUTO_INCREMENT=1;

CREATE TABLE MENOON.QUESTION_CHOICES
(
Q_ID INT NOT NULL,
Q_CHOICE_CHAR CHAR(1) NOT NULL,
Q_CHOICE_CONTENT VARCHAR(100),
Q_CHOICE_IMAGE BLOB,

PRIMARY KEY(Q_ID,Q_CHOICE_CHAR),

FOREIGN KEY(Q_ID)REFERENCES IQ_QUESTIONS(ID)
ON UPDATE CASCADE ON DELETE CASCADE

);

CREATE TABLE MENOON.EVENT_IQ_TEST
(
EVENT_ID INT NOT NULL,
Q_ID INT NOT NULL,

PRIMARY KEY(EVENT_ID,Q_ID),

FOREIGN KEY(EVENT_ID)REFERENCES EVENTS(ID)
ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(Q_ID)REFERENCES IQ_QUESTIONS(ID)
ON UPDATE CASCADE ON DELETE CASCADE

);

CREATE TABLE MENOON.ADMINS
(
ID INT NOT NULL AUTO_INCREMENT,
FULLNAME VARCHAR(50),
USERNAME VARCHAR(50) UNIQUE,
PASSWORD INT,
ROLE VARCHAR(50),
ACTIVATION_DATE DATE,
EXPIRATION_DATE DATE,
ACTIVATED BIT DEFAULT 1,

PRIMARY KEY(ID)


);

ALTER TABLE ADMINS AUTO_INCREMENT=1;

CREATE TABLE MENOON.ADMIN_EMAILS
(
 ADMIN_ID INT NOT NULL,
 EMAIL VARCHAR(320),
 

 PRIMARY KEY(ADMIN_ID,EMAIL),

FOREIGN KEY(ADMIN_ID) REFERENCES ADMINS(ID)
ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE MENOON.ADMIN_PHONENUMBERS
(
 ADMIN_ID INT NOT NULL,
COUNTRY_CODE VARCHAR(5),
PHONENUMBER VARCHAR(15),
 

 PRIMARY KEY(ADMIN_ID,COUNTRY_CODE,PHONENUMBER),

FOREIGN KEY(ADMIN_ID) REFERENCES ADMINS(ID)
ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE MENOON.EVENT_ADMIN
(
ADMIN_ID INT NOT NULL,
EVENT_ID INT NOT NULL,

PRIMARY KEY(ADMIN_ID,EVENT_ID),

FOREIGN KEY(ADMIN_ID) REFERENCES ADMINS(ID)
ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(EVENT_ID)REFERENCES EVENTS(ID)
 ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE MENOON.EVENT_ATTENDANCE
(
USER_ID INT NOT NULL,
EVENT_ID INT NOT NULL,
DAY DATE,
STATUS BIT DEFAULT 0,

PRIMARY KEY(USER_ID,EVENT_ID,DAY),

FOREIGN KEY(EVENT_ID)REFERENCES EVENTS(ID)
 ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY(USER_ID) REFERENCES USER(ID)
ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE MENOON.CONTACT_REQUESTS
(
ID INT NOT NULL AUTO_INCREMENT,
EMAIL VARCHAR(320),
COUNTRY_CODE VARCHAR(5),
PHONENUMBER VARCHAR(15),
CONTENT VARCHAR(5000),

PRIMARY KEY(ID)


);

ALTER TABLE CONTACT_REQUESTS AUTO_INCREMENT=1;

CREATE TABLE MENOON.GUEST_NEWSLETTER
(
ID INT NOT NULL AUTO_INCREMENT,
EMAIL VARCHAR(320) UNIQUE,

PRIMARY KEY(ID)

);

ALTER TABLE GUEST_NEWSLETTER AUTO_INCREMENT=1;
