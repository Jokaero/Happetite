UPDATE engine4_album_albums
SET category_id = (SELECT * 
                   FROM (SELECT MAX(category_id) + 1 
                         FROM engine4_album_categories  
                         WHERE category_id < (SELECT MAX(category_id) 
                                              FROM engine4_album_categories)) AS t)
WHERE category_id = (SELECT * FROM (SELECT MAX(category_id) FROM engine4_album_categories ) AS t);

UPDATE engine4_album_categories 
SET category_id = (SELECT * 
                   FROM (SELECT MAX(category_id) + 1 
                         FROM engine4_album_categories  
                         WHERE category_id < (SELECT MAX(category_id) 
                                              FROM engine4_album_categories)) AS t)
WHERE category_id = (SELECT * FROM (SELECT MAX(category_id) FROM engine4_album_categories ) AS t);


ALTER TABLE engine4_album_categories AUTO_INCREMENT = 1;
