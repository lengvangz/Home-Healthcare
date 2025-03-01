# 🩺 Home Healthcare
<img src="https://github.com/lengvangz/images/blob/main/image.png" alt="Image" width="50%" height="50%">

## 📖 Table of Contents
- [Situation](#Situation)
- [Task](#Task)
- [Actions](#Actions)
	- [Diagram](#Diagram)
	- [SQL](#SQL) 	

***

## Situation 
An up-and-coming businessman had an idea to open a home healthcare agency. His goal was to provide nursing services to the community. He wanted to help the sick, the disabled, and the vulnerable.

Fast forward to today, he now owns an agency that contracts with the State Department of Human Services. He also has hundreds of clients, personal care assistants (PCAs), and a couple dozen employees. The startup company is now worth millions of dollars.

***

## Task

To keep up with his fast-growing business, the businessman wants a new design for storing data. He wants a data table to store information on employees, clients, and PCAs. He also wants an easy way to extract and transform the data. Additionally, he wants answers to his questions regarding optimizing business performance, client services, and data integrity.

***

## Actions 

### Diagram

<img src="https://github.com/lengvangz/images/blob/main/home%20healthcare%20ERD.png" alt="Image" width="100%" height="100%">

### SQL 

** How many coordinators does each manager supervise?

```sql
SELECT
	m.manager_name,
	COUNT(coord_id) AS num_coordinators
FROM 
	coordinator c
INNER JOIN manager m
	ON m.manager_id = c.manager_id
GROUP BY
	m.manager_name;

````

#### Answer:
| manager_name | num_coordinators |
| ----------- | ----------- |
| Manager A           | 8          |
| Manager B           | 5          |
| Manager C           | 7          |

***

**How many PCAs and Clients does each coordinators has?*

````sql
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
	coord_name;

````

#### Answer:
| coffee_name | num_client | num_pca |
| ----------- | ----------- | ----------- |
| Coordinator  A | 3           | 3 |
| Coordinator  B | 8           | 8 |
| Coordinator  C | 7           | 7 |

PS. The answer above only show 3 out of the 20 rows

***

**Which PCA does not have a client?**

````sql
SELECT 
	pca_name
FROM 
	pca p
WHERE NOT EXISTS 
	(SELECT 1 FROM client_case c WHERE p.pca_id = c.pca_id)
ORDER BY 
	pca_name;
````

#### Answer:
| pca_name |   
| ----------- | 
| PCA AN           |        
| PCA BD           |       
| PCA DF          |          
| PCA DG      | 	   
| PCA DH      |    
| PCA DJ        |       
| PCA DL        |         
| PCA DN        |         
| PCA E      | 	   
| PCA G      | 
| PCA U      | 

***

**What is the distriubtion of client cases based on insurance?**

````sql
SELECT
	insurance,
	COUNT(*)
FROM 
	client
GROUP BY
	insurance
ORDER BY
	COUNT(*) DESC;
````

#### Answer:
| insurance | count  |
| ----------- | ------------- |
| health guard           | 21  	      | 
| vitality plan           | 14         |
| wellness shield           | 14         |
| care coverage	      | 13         |
| health assurance	      | 13         |
| secure health	      | 13         |
| wellbeing health	      |6         |
| life shield	      | 5         |
| life shield	      | 1         |


***

**Which client are the age of 64 and have insurance health guard?**

````sql
SELECT 
	client_name,
	EXTRACT(YEAR FROM age(client_dob)) AS age
FROM 
	client
WHERE 
	insurance LIKE 'health guard'
	AND EXTRACT(YEAR FROM age(client_dob)) :: int > 64
GROUP BY
	client_name,
	age;
````

#### Answer:
| client_name | age  |  
| ----------- | ------------- |  
|           |       |


***

**Are all PCA linked to a coordinator, but not assigned to any client?**

````sql
SELECT 
	pca_name
FROM 
	pca p
INNER JOIN client_case c
	ON p.pca_id = c.pca_id
WHERE 
	client_id = ' ' OR client_id IS NULL;
````

#### Answer:
| pca_name |
| ----------- |
|            |

***
