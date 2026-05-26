CREATE DATABASE Restaurant_Project;

USE Restaurant_Project;

CREATE TABLE consumers (
    Consumer_ID VARCHAR(10) PRIMARY KEY,
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    Latitude DECIMAL(10,6),
    Longitude DECIMAL(10,6),
    Smoker VARCHAR(10),
    Drink_Level VARCHAR(50),
    Transportation_Method VARCHAR(50),
    Marital_Status VARCHAR(50),
    Children VARCHAR(50),
    Age INT,
    Occupation VARCHAR(100),
    Budget VARCHAR(50)
);

SELECT * FROM consumers;

CREATE TABLE restaurants (
    Restaurant_ID INT PRIMARY KEY,
    Name VARCHAR(200),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    Zip_Code VARCHAR(20),
    Latitude DECIMAL(10,6),
    Longitude DECIMAL(10,6),
    Alcohol_Service VARCHAR(50),
    Smoking_Allowed VARCHAR(50),
    Price VARCHAR(50),
    Franchise VARCHAR(10),
    Area VARCHAR(100),
    Parking VARCHAR(100)
);

CREATE TABLE consumer_preferences (
    Consumer_ID VARCHAR(10),
    Preferred_Cuisine VARCHAR(100)
);

SELECT * FROM consumer_preferences;

CREATE TABLE restaurant_cuisines (
    Restaurant_ID INT,
    Cuisine VARCHAR(100)
);

SELECT * FROM restaurant_cuisines;

CREATE TABLE ratings (
    Consumer_ID VARCHAR(10),
    Restaurant_ID INT,
    Overall_Rating INT,
    Food_Rating INT,
    Service_Rating INT
);
SELECT * FROM ratings;

SELECT * 
FROM consumers;

SELECT * 
FROM restaurants;

SELECT *
FROM consumers
WHERE City = 'Cuernavaca';

SELECT c.Consumer_ID,
       r.Name
FROM consumers c
JOIN ratings rt
ON c.Consumer_ID = rt.Consumer_ID
JOIN restaurants r
ON rt.Restaurant_ID = r.Restaurant_ID;

SELECT Restaurant_ID,
       AVG(Overall_Rating)
FROM ratings
GROUP BY Restaurant_ID;

SELECT Restaurant_ID,
       AVG(Overall_Rating) AS Avg_Rating
FROM ratings
GROUP BY Restaurant_ID
HAVING AVG(Overall_Rating) > 1;

SELECT Restaurant_ID
FROM ratings
WHERE Overall_Rating = 2;

SELECT Name, City
FROM restaurants
WHERE Restaurant_ID IN
(
    SELECT Restaurant_ID
    FROM ratings
    WHERE Overall_Rating = 2
);

SELECT Consumer_ID, Age, Occupation
FROM consumers
WHERE Consumer_ID NOT IN
(
    SELECT Consumer_ID
    FROM ratings
);

SELECT Consumer_ID, Age, Occupation
FROM consumers
WHERE Consumer_ID NOT IN
(
    SELECT Consumer_ID
    FROM ratings
);

SELECT Name, City
FROM restaurants
WHERE Price = 'Medium';

SELECT Name, City
FROM restaurants
WHERE Price = 'Medium'
AND Alcohol_Service = 'Wine & Beer';

SELECT Name, City
FROM restaurants
WHERE Franchise = 'Yes';

SELECT Consumer_ID,
       Age,
       Occupation
FROM consumers
WHERE Occupation = 'Student'
AND Smoker = 'Yes';

SELECT Consumer_ID,
       Restaurant_ID,
       Overall_Rating
FROM ratings
WHERE Overall_Rating = 2;

SELECT DISTINCT r.Name,
       r.City
FROM restaurants r
JOIN ratings rt
ON r.Restaurant_ID = rt.Restaurant_ID
WHERE rt.Overall_Rating = 2;

SELECT DISTINCT c.Consumer_ID,
       c.Age
FROM consumers c
JOIN ratings rt
ON c.Consumer_ID = rt.Consumer_ID
JOIN restaurants r
ON rt.Restaurant_ID = r.Restaurant_ID
WHERE r.City = 'San Luis Potosi';

SELECT DISTINCT r.Name
FROM restaurants r
JOIN restaurant_cuisines rc
ON r.Restaurant_ID = rc.Restaurant_ID
JOIN ratings rt
ON r.Restaurant_ID = rt.Restaurant_ID
WHERE rc.Cuisine = 'Mexican'
AND rt.Consumer_ID = 'U1001';

SELECT c.*
FROM consumers c
JOIN consumer_preferences cp
ON c.Consumer_ID = cp.Consumer_ID
WHERE cp.Preferred_Cuisine = 'American'
AND c.Budget = 'Medium';

SELECT r.Name,
       r.City
FROM restaurants r
JOIN ratings rt
ON r.Restaurant_ID = rt.Restaurant_ID
GROUP BY r.Restaurant_ID, r.Name, r.City
HAVING AVG(rt.Food_Rating) <
(
    SELECT AVG(Food_Rating)
    FROM ratings
);

SELECT DISTINCT c.Consumer_ID,
       c.Age,
       c.Occupation
FROM consumers c
WHERE c.Consumer_ID IN
(
    SELECT Consumer_ID
    FROM ratings
)
AND c.Consumer_ID NOT IN
(
    SELECT rt.Consumer_ID
    FROM ratings rt
    JOIN restaurant_cuisines rc
    ON rt.Restaurant_ID = rc.Restaurant_ID
    WHERE rc.Cuisine = 'Italian'
);

SELECT DISTINCT r.Name
FROM restaurants r
JOIN ratings rt
ON r.Restaurant_ID = rt.Restaurant_ID
JOIN consumers c
ON rt.Consumer_ID = c.Consumer_ID
WHERE c.Age > 30;

SELECT DISTINCT c.Consumer_ID,
       c.Occupation
FROM consumers c
JOIN consumer_preferences cp
ON c.Consumer_ID = cp.Consumer_ID
JOIN ratings rt
ON c.Consumer_ID = rt.Consumer_ID
WHERE cp.Preferred_Cuisine = 'Mexican'
AND rt.Overall_Rating = 0;

SELECT DISTINCT r.Name,
       r.City
FROM restaurants r
JOIN restaurant_cuisines rc
ON r.Restaurant_ID = rc.Restaurant_ID
WHERE rc.Cuisine = 'Pizzeria'
AND r.City IN
(
    SELECT City
    FROM consumers
    WHERE Occupation = 'Student'
);

SELECT DISTINCT c.Consumer_ID,
       c.Age
FROM consumers c
JOIN ratings rt
ON c.Consumer_ID = rt.Consumer_ID
JOIN restaurants r
ON rt.Restaurant_ID = r.Restaurant_ID
WHERE c.Drink_Level = 'Social Drinker'
AND r.Parking = 'No';

SELECT c.Consumer_ID,
       COUNT(rt.Restaurant_ID) AS Total_Ratings
FROM consumers c
JOIN ratings rt
ON c.Consumer_ID = rt.Consumer_ID
WHERE c.Occupation = 'Student'
GROUP BY c.Consumer_ID
HAVING COUNT(rt.Restaurant_ID) > 2;

SELECT Consumer_ID,
       Age,
       FLOOR(Age / 10) AS Engagement_Score
FROM consumers
WHERE FLOOR(Age / 10) = 2
AND Transportation_Method = 'Public';

SELECT r.Name,
       r.City,
       AVG(rt.Overall_Rating) AS Avg_Rating
FROM restaurants r
JOIN ratings rt
ON r.Restaurant_ID = rt.Restaurant_ID
WHERE r.City = 'Cuernavaca'
GROUP BY r.Restaurant_ID, r.Name, r.City
HAVING AVG(rt.Overall_Rating) > 1.0;

SELECT DISTINCT c.Consumer_ID,
       c.Age
FROM consumers c
JOIN ratings rt
ON c.Consumer_ID = rt.Consumer_ID
WHERE c.Marital_Status = 'Married'
AND rt.Food_Rating = rt.Service_Rating
AND rt.Overall_Rating = 2;

SELECT DISTINCT c.Consumer_ID,
       c.Age,
       r.Name
FROM consumers c
JOIN ratings rt
ON c.Consumer_ID = rt.Consumer_ID
JOIN restaurants r
ON rt.Restaurant_ID = r.Restaurant_ID
WHERE c.Occupation = 'Employed'
AND rt.Food_Rating = 0
AND r.City = 'Ciudad Victoria';

WITH SLP_Consumers AS
(
    SELECT *
    FROM consumers
    WHERE City = 'San Luis Potosi'
)

SELECT sc.Consumer_ID,
       sc.Age,
       r.Name
FROM SLP_Consumers sc
JOIN ratings rt
ON sc.Consumer_ID = rt.Consumer_ID
JOIN restaurants r
ON rt.Restaurant_ID = r.Restaurant_ID
JOIN restaurant_cuisines rc
ON r.Restaurant_ID = rc.Restaurant_ID
WHERE rc.Cuisine = 'Mexican'
AND rt.Overall_Rating = 2;

SELECT Occupation,
       AVG(Age) AS Avg_Age
FROM
(
    SELECT DISTINCT c.Consumer_ID,
           c.Age,
           c.Occupation
    FROM consumers c
    JOIN ratings rt
    ON c.Consumer_ID = rt.Consumer_ID
) rated_consumers
GROUP BY Occupation;

WITH CuernavacaRatings AS
(
    SELECT rt.*
    FROM ratings rt
    JOIN restaurants r
    ON rt.Restaurant_ID = r.Restaurant_ID
    WHERE r.City = 'Cuernavaca'
)

SELECT Restaurant_ID,
       Consumer_ID,
       Overall_Rating,
       RANK() OVER
       (
           PARTITION BY Restaurant_ID
           ORDER BY Overall_Rating DESC
       ) AS RatingRank
FROM CuernavacaRatings;

SELECT Consumer_ID,
       Restaurant_ID,
       Overall_Rating,
       AVG(Overall_Rating) OVER
       (
           PARTITION BY Consumer_ID
       ) AS Consumer_Avg_Rating
FROM ratings;

WITH LowBudgetStudents AS
(
    SELECT Consumer_ID
    FROM consumers
    WHERE Occupation = 'Student'
    AND Budget = 'Low'
)

SELECT *
FROM
(
    SELECT cp.Consumer_ID,
           cp.Preferred_Cuisine,
           ROW_NUMBER() OVER
           (
               PARTITION BY cp.Consumer_ID
               ORDER BY cp.Preferred_Cuisine
           ) AS rn
    FROM consumer_preferences cp
    JOIN LowBudgetStudents lbs
    ON cp.Consumer_ID = lbs.Consumer_ID
) t
WHERE rn <= 3;

SELECT Restaurant_ID,
       Overall_Rating,
       LEAD(Overall_Rating)
       OVER (ORDER BY Restaurant_ID) AS Next_Rating
FROM
(
    SELECT *
    FROM ratings
    WHERE Consumer_ID = 'U1008'
) t;
CREATE VIEW HighlyRatedMexicanRestaurants AS

SELECT r.Restaurant_ID,
       r.Name,
       r.City
FROM restaurants r
JOIN restaurant_cuisines rc
ON r.Restaurant_ID = rc.Restaurant_ID
JOIN ratings rt
ON r.Restaurant_ID = rt.Restaurant_ID
WHERE rc.Cuisine = 'Mexican'
GROUP BY r.Restaurant_ID, r.Name, r.City
HAVING AVG(rt.Overall_Rating) > 1.5;

WITH MexicanConsumers AS
(
    SELECT DISTINCT Consumer_ID
    FROM consumer_preferences
    WHERE Preferred_Cuisine = 'Mexican'
)

SELECT mc.Consumer_ID
FROM MexicanConsumers mc
WHERE mc.Consumer_ID NOT IN
(
    SELECT DISTINCT rt.Consumer_ID
    FROM ratings rt
    JOIN HighlyRatedMexicanRestaurants hm
    ON rt.Restaurant_ID = hm.Restaurant_ID
);

DELIMITER //

CREATE PROCEDURE GetRestaurantRatingsAboveThreshold
(
    IN p_Restaurant_ID INT,
    IN p_Min_Rating INT
)

BEGIN

SELECT Consumer_ID,
       Overall_Rating,
       Food_Rating,
       Service_Rating
FROM ratings
WHERE Restaurant_ID = p_Restaurant_ID
AND Overall_Rating >= p_Min_Rating;

END //

DELIMITER ;

CALL GetRestaurantRatingsAboveThreshold(135085, 1);

WITH RestaurantRatings AS
(
    SELECT rc.Cuisine,
           r.Name AS Restaurant_Name,
           r.City,
           AVG(rt.Overall_Rating) AS Avg_Rating
    FROM restaurants r
    JOIN restaurant_cuisines rc
    ON r.Restaurant_ID = rc.Restaurant_ID
    JOIN ratings rt
    ON r.Restaurant_ID = rt.Restaurant_ID
    GROUP BY rc.Cuisine, r.Restaurant_ID, r.Name, r.City
),

RankedRestaurants AS
(
    SELECT *,
           DENSE_RANK() OVER
           (
               PARTITION BY Cuisine
               ORDER BY Avg_Rating DESC
           ) AS rnk
    FROM RestaurantRatings
)

SELECT Cuisine,
       Restaurant_Name,
       City,
       Avg_Rating
FROM RankedRestaurants
WHERE rnk <= 2;

CREATE VIEW ConsumerAverageRatings AS

SELECT Consumer_ID,
       AVG(Overall_Rating) AS Avg_Rating
FROM ratings
GROUP BY Consumer_ID;

WITH TopConsumers AS
(
    SELECT Consumer_ID,
           Avg_Rating
    FROM ConsumerAverageRatings
    ORDER BY Avg_Rating DESC
    LIMIT 5
)

SELECT tc.Consumer_ID,
       tc.Avg_Rating,
       COUNT(*) AS Mexican_Restaurants_Rated
FROM TopConsumers tc
JOIN ratings rt
ON tc.Consumer_ID = rt.Consumer_ID
JOIN restaurant_cuisines rc
ON rt.Restaurant_ID = rc.Restaurant_ID
WHERE rc.Cuisine = 'Mexican'
GROUP BY tc.Consumer_ID, tc.Avg_Rating;

DELIMITER //

CREATE PROCEDURE GetConsumerSegmentAndRestaurantPerformance
(
    IN p_Consumer_ID VARCHAR(10)
)

BEGIN

SELECT
    c.Consumer_ID,

    CASE
        WHEN c.Budget = 'Low'
            THEN 'Budget Conscious'

        WHEN c.Budget = 'Medium'
            THEN 'Moderate Spender'

        WHEN c.Budget = 'High'
            THEN 'Premium Spender'

        ELSE 'Unknown Budget'
    END AS Spending_Segment,

    r.Name AS Restaurant_Name,

    rt.Overall_Rating,

    AVG(rt2.Overall_Rating) AS Restaurant_Avg_Rating,

    CASE
        WHEN rt.Overall_Rating >
             AVG(rt2.Overall_Rating)
             THEN 'Above Average'

        WHEN rt.Overall_Rating =
             AVG(rt2.Overall_Rating)
             THEN 'At Average'

        ELSE 'Below Average'
    END AS Performance_Flag,

    RANK() OVER
    (
        ORDER BY rt.Overall_Rating DESC
    ) AS Rating_Rank

FROM consumers c

JOIN ratings rt
ON c.Consumer_ID = rt.Consumer_ID

JOIN restaurants r
ON rt.Restaurant_ID = r.Restaurant_ID

JOIN ratings rt2
ON r.Restaurant_ID = rt2.Restaurant_ID

WHERE c.Consumer_ID = p_Consumer_ID

GROUP BY
    c.Consumer_ID,
    c.Budget,
    r.Name,
    rt.Overall_Rating;

END //

DELIMITER ;

