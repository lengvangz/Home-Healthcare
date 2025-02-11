DROP TABLE IF EXISTS manager;
CREATE TABLE manager (
	manager_id VARCHAR(5) PRIMARY KEY,
	manager_name VARCHAR(255)
);

DROP TABLE IF EXISTS coordinator;
CREATE TABLE coordinator (
	coord_id VARCHAR(5) PRIMARY KEY,
	coord_name VARCHAR(255),
	phone_number varchar(10),
	manager_id VARCHAR(5) REFERENCES manager(manager_id)
);

DROP TABLE IF EXISTS client;
CREATE TABLE client (
	client_id VARCHAR(5) PRIMARY KEY,
	client_name VARCHAR(255),
	insurance VARCHAR (255),
    client_DOB DATE
);

DROP TABLE IF EXISTS pca;
CREATE TABLE pca (
	pca_id VARCHAR(6) PRIMARY KEY,
	pca_name VARCHAR(255),
	pca_DOB DATE
);

DROP TABLE IF EXISTS client_case;
CREATE TABLE client_case (
	client_id VARCHAR(5) REFERENCES client(client_id),
	pca_id VARCHAR(6) REFERENCES pca(pca_id),
	coord_id VARCHAR(5) REFERENCES coordinator(coord_id),
	start_time TIME,
	end_time TIME
);
