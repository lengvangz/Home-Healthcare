-- How many coordinators does each manager supervise?

SELECT
	m.manager_name,
	COUNT(coord_id) AS num_coordinators
FROM 
	coordinator c
INNER JOIN manager m
	ON m.manager_id = c.manager_id
GROUP BY
	m.manager_name;

-- How many PCAs and Clients does each coordinators has?

SELECT 
	coord_name,
	COUNT(DISTINCT client_id) AS num_client,
	COUNT(DISTINCT pca_id) AS num_pca
FROM
	coordinator c
INNER JOIN client_case cc
	ON c.coord_id = cc.coord_id
GROUP BY
	coord_name
ORDER BY
	num_client DESC;

-- Which PCA does not have a client?

SELECT pca_name
FROM pca p
WHERE NOT EXISTS (SELECT 1 FROM client_case c WHERE p.pca_id = c.pca_id)
ORDER BY pca_name;

-- How many PCAs are working over 10 hours a day?

SELECT
	p.pca_id,
	p.pca_name
FROM 
	pca p
INNER JOIN client_case c
	ON p.pca_id = c.pca_id
WHERE
	end_time - start_time > interval '10 hours'
GROUP BY
	p.pca_id,
	p.pca_name
ORDER BY
	p.pca_id;

-- What is the distriubtion of client cases based on insurance?

SELECT
	insurance,
	COUNT(*)
FROM 
	client
GROUP BY
	insurance
ORDER BY
	COUNT(*) DESC;

-- Which client are the age of 64 and have insurance *insurance name*?

SELECT 
	client_name,
	EXTRACT(YEAR FROM age(client_dob)) AS age
FROM 
	client
WHERE 
	insurance LIKE 'health guard'
	AND EXTRACT(YEAR FROM age(client_dob)) :: int > 64
group by 
	client_name,
	age;

-- Are all PCA linked to a coordinator, but not assigned to any client?

SELECT 
	pca_name
FROM 
	pca p
INNER JOIN client_case c
	ON p.pca_id = c.pca_id
WHERE 
	client_id = ' ' OR client_id IS NULL;

