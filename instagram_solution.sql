-- Solutions to Ultimate MySQL bootcamp by Colt Steele 'Instagram Databases' problem.

-- First question
-- Select the 5 oldest users.

SELECT username, created_at 
FROM users ORDER BY created_at LIMIT 5;


-- Second question
-- Show which days have maximum numbers of users signing up.

SELECT DATE_FORMAT(created_at,'%W') AS 'Day Name',
COUNT(DATE_FORMAT(created_at,'%W')) AS 'Counter' FROM users 
GROUP BY 'Day Name' ORDER BY 'Counter';

-- Third question
-- Select users that have not uploaded any pictures on 'instagram'.

SELECT username 
FROM users LEFT JOIN
photos ON 
users.id = photos.user_id 
WHERE photos.user_id IS NULL;

-- Fourth question
-- Select the Top 10 most liked images on 'instagram'.

SELECT username, image_url, COUNT(photo_id) AS counter FROM users 
JOIN photos ON users.id = photos.user_id 
JOIN likes ON likes.photo_id = photos.photo_id
GROUP BY image_url ORDER BY counter DESC LIMIT 10;

-- Fifth question
-- Select the average number of likes per user on the platform.

SELECT ROUND((SELECT COUNT(*) from photos / SELECT count(*) FROM users),2) AS 'Avg per user';

--               OR
                
SELECT ROUND(COUNT(photos.id)/ COUNT(DISTINCT(users.id)),2) AS 'Avg per user' FROM users LEFT JOIN photos ON users.id = photos.user_id;


-- Sixth question
-- Select the 5 most popular photo tags used.

SELECT tag_name, COUNT(tag_id) AS counter 
FROM tags 
JOIN photo_tags 
ON tags.id = photo_tags.tag_id 
GROUP BY tag_name ORDER BY counter DESC LIMIT 5;


-- Seventh question
-- Select users that have like every photo on the site (potential bots).

SELECT username, COUNT(*) AS counter
FROM users 
JOIN likes 
ON users.id = likes.user_id
GROUP BY user_id 
HAVING counter = (
SELECT COUNT(*) FROM photos);