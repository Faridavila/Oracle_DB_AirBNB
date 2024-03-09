REM
REM Autor: Farid Daliang Avila Piedrahita 
REM
REM Fecha 08/03/2024
REM
REM DESCRIPTON
REM   El script cuenta con los siguientes parametros:
REM  - Crear la base de datos correspondiente al schema relacional presentado
REM  - Por cada tabla (table), un comando create table
REM  - Por cada restricción (constraint), un comando alter table
REM
REM Creacion de un nuevo usuario
CREATE USER Airbnb
IDENTIFIED BY Airbnb317;

REM Dar los privilegios necesarios a el nuevo usuario
GRANT create session, create table,
create sequence, create view
TO Airbnb with ADMIN OPTION;

REM Nos conectamos a el usuario Airbnb
CONNECT Airbnb/Airbnb317@localhost:1521/xepdb1;

REM Se crean las tablas corresponientes del schema relacional

CREATE TABLE USER_AIRBNB (
    id_user VARCHAR2(255),
    updated_at TIMESTAMP,
    created_at TIMESTAMP,
    email VARCHAR2(255),
    password_air VARCHAR2(255),
    first_name VARCHAR2(255),
    last_name VARCHAR2(255)
);


CREATE TABLE AMENITY (
    id_amenity VARCHAR2(255),
    updated_at TIMESTAMP,
    created_at TIMESTAMP,
    name_amenity VARCHAR2(255)
);


CREATE TABLE STATE_AIRBNB(
    id_state VARCHAR2(255),
    updated_at TIMESTAMP,
    created_at TIMESTAMP,
    name_state VARCHAR2(255)
);


CREATE TABLE CITY (
    id_city VARCHAR2(255),
    updated_at TIMESTAMP,
    created_at TIMESTAMP,
    state_id VARCHAR2(255),
    name_city VARCHAR2(255)
    
);


CREATE TABLE PLACE_AMENITY (
    amenity_id VARCHAR2(255),
    place_id VARCHAR2(255)
);


CREATE TABLE REVIEW (
    id_review VARCHAR2(255),
    updated_at TIMESTAMP,
    created_at TIMESTAMP,
    user_id VARCHAR2(255),
    place_id VARCHAR2(255),
    text_review VARCHAR2(255)
);


CREATE TABLE PLACE (
    id_place VARCHAR2(255),
    updated_at TIMESTAMP,
    created_at TIMESTAMP,
    user_id VARCHAR2(255),
    name_place VARCHAR2(255),
    city_id VARCHAR2(255),
    description_place VARCHAR2(255),
    number_rooms INTEGER DEFAULT 0,
    number_bathrooms INTEGER DEFAULT 0,
    max_guest INTEGER DEFAULT 0,
    price_by_night INTEGER DEFAULT 0,
    latitude FLOAT,
    longitude FLOAT
);



--ALTER TABLE de las primary key 
ALTER TABLE USER_AIRBNB ADD CONSTRAINT pk_user PRIMARY KEY (id_user);

ALTER TABLE AMENITY ADD CONSTRAINT pk_amenity PRIMARY KEY (id_amenity);

ALTER TABLE STATE_AIRBNB ADD CONSTRAINT pk_state PRIMARY KEY (id_state);

ALTER TABLE CITY ADD CONSTRAINT pk_city PRIMARY KEY (id_city);

ALTER TABLE REVIEW ADD CONSTRAINT pk_review PRIMARY KEY (id_review);

ALTER TABLE PLACE ADD CONSTRAINT pk_place PRIMARY KEY (id_place);


--ALTER TABLE de las foreign key

ALTER TABLE CITY ADD CONSTRAINT fk_city_state FOREIGN KEY (state_id) REFERENCES STATE_AIRBNB(id_state);

ALTER TABLE PLACE_AMENITY ADD CONSTRAINT fk_place_amenity_amenity FOREIGN KEY (amenity_id) REFERENCES AMENITY(id_amenity);

ALTER TABLE PLACE_AMENITY ADD CONSTRAINT fk_place_amenity_place FOREIGN KEY (place_id) REFERENCES PLACE(id_place);

ALTER TABLE REVIEW ADD CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES USER_AIRBNB(id_user);

ALTER TABLE REVIEW ADD CONSTRAINT fk_review_place FOREIGN KEY (place_id) REFERENCES PLACE(id_place);

ALTER TABLE PLACE ADD CONSTRAINT fk_place_user FOREIGN KEY (user_id) REFERENCES USER_AIRBNB(id_user);

ALTER TABLE PLACE ADD CONSTRAINT fk_place_city FOREIGN KEY (city_id) REFERENCES CITY(id_city);
