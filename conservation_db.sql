-- Active: 1747402242553@@127.0.0.1@5432@conservation_db
create DATABASE conservation_db;

create Table rangers(
    ranger_id SERIAL PRIMARY KEY,
    name TEXT ,
    region TEXT 

);

ALTER TABLE rangers ADD COLUMN Derek Fox ,Coastal Plains TEXT;
SELECT * FROM rangers;
DROP Table rangers;

INSERT INTO rangers (ranger_id,name,region)
VALUES
(1, 'Alice Green', 'Northern Hills'),
(2, 'Bob White', 'River Delta'),
(3, 'Carol King', 'Mountain Range'),
(4, 'David Smith', 'Eastern Wetlands'),
(5, 'Emma Johnson', 'Central Forest'),
(6, 'Frank Brown', 'Southern Plains'),
(7, 'Grace Lee', 'Western Grasslands'),
(8, 'Henry Adams', 'Coastal Dunes')


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
(4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
(5, 'Indian Pangolin', 'Manis crassicaudata', '1822-01-01', 'Endangered'),
(6, 'Himalayan Monal', 'Lophophorus impejanus', '1790-01-01', 'Least Concern'),
(7, 'Indian Rhinoceros', 'Rhinoceros unicornis', '1758-01-01', 'Vulnerable'),
(8, 'Blackbuck', 'Antilope cervicapra', '1823-01-01', 'Near Threatened');



SELECT * FROM species;
DROP TABLE species;

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
(2, 1, '2024-05-18 18:30:00', 'Snowfall Pass', NULL),
(1, 3, '2024-06-01 12:15:00', 'Highland Trail', 'Nest spotted'),
(3, 2, '2024-06-03 14:40:00', 'Riverbank Edge', 'Tracks seen'),
(1, 4, '2024-06-07 08:00:00', 'Forest Clearing', 'Herd movement observed'),
(2, 4, '2024-06-10 17:30:00', 'Eastern Wetlands', 'Young calf seen');


SELECT * FROM sightings;

DROP Table sightings;


-- 1 problem 

INSERT INTO rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');


INSERT INTO rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- problem 3 
SELECT * FROM sightings WHERE location  ILIKE '%pass%';
SELECT * FROM sightings;


SELECT r.name, COUNT(s.sighting_id) AS total_sightings
FROM rangers r
LEFT JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY r.name;
