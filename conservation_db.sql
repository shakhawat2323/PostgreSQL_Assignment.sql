-- Active: 1747402242553@@127.0.0.1@5432@conservation_db
create DATABASE conservation_db;

create Table rangers(
    ranger_id SERIAL PRIMARY KEY,
    name TEXT ,
    region TEXT 

);

SELECT * FROM rangers;


INSERT INTO rangers (ranger_id,name,region)
VALUES
(1, 'Alice Green', 'Northern Hills'),
(2, 'Bob White', 'River Delta'),
(3, 'Carol King', 'Mountain Range');



CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) ,
    scientific_name VARCHAR(100) ,
    discovery_date DATE,
    conservation_status VARCHAR(100)
);

INSERT INTO species(species_id,common_name,scientific_name,  discovery_date,conservation_status)
VALUES
(1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');



SELECT * FROM species;


CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,

    sighting_time TIMESTAMP NOT NULL,

    location VARCHAR(200) NOT NULL,

    ranger_id INTEGER NOT NULL REFERENCES rangers(ranger_id),
    species_id INTEGER NOT NULL REFERENCES species(species_id),

    notes TEXT
);
INSERT INTO sightings (ranger_id, species_id, sighting_time, location, notes) VALUES
(1, 1, '2024-05-10 07:45:00', 'Peak Ridge', 'Camera trap image captured'),
(2, 2, '2024-05-12 16:20:00', 'Bankwood Area', 'Juvenile seen'),
(3, 3, '2024-05-15 09:10:00', 'Bamboo Grove East', 'Feeding observed'),
(2, 1, '2024-05-18 18:30:00', 'Snowfall Pass', NULL)



SELECT * FROM sightings;



-- 1 problem 
INSERT INTO rangers (name,region)
VALUES
    ('Coastal Plains','Coastal Plains');


-- problem 2
SELECT * FROM sightings 
WHERE location  ILIKE '%pass%';




-- problem 3
SELECT COUNT(DISTINCT species_id) AS unique_species_count FROM sightings;


--  problem 4

SELECT r.name, COUNT(s.sighting_id) AS total_sightings FROM rangers r
JOIN sightings s ON r.ranger_id = s.ranger_id GROUP BY r.name ORDER BY r.name;



--  problem 5

SELECT s.common_name FROM species s LEFT JOIN sightings si ON s.species_id = si.species_id
WHERE si.species_id IS NULL;

--  problem 6 

SELECT sp.common_name, si.sighting_time, r.name FROM sightings si
JOIN species sp ON si.species_id = sp.species_id JOIN rangers r ON si.ranger_id = r.ranger_id
ORDER BY si.sighting_time DESC LIMIT 2;

--  problem 7

UPDATE species SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

--  problem 8

SELECT sighting_id,
       CASE
           WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
           WHEN EXTRACT(HOUR FROM sighting_time) < 17 THEN 'Afternoon'
           ELSE 'Evening'
       END AS time_of_day
FROM sightings;

--  problem 9

DELETE FROM rangers
WHERE ranger_id NOT IN (SELECT DISTINCT ranger_id FROM sightings);


